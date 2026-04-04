import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { serve } from 'https://deno.land/std@0.224.0/http/server.ts';

const jsonHeaders = {
  'Content-Type': 'application/json',
};

type PaystackWebhook = {
  event?: string;
  data?: {
    reference?: string;
    status?: string;
    amount?: number;
    metadata?: {
      order_code?: string;
      [key: string]: unknown;
    };
    [key: string]: unknown;
  };
};

function timingSafeEqual(a: string, b: string): boolean {
  if (a.length != b.length) {
    return false;
  }

  let mismatch = 0;
  for (let i = 0; i < a.length; i++) {
    mismatch |= a.charCodeAt(i) ^ b.charCodeAt(i);
  }
  return mismatch == 0;
}

async function hmacSha512Hex(secret: string, payload: string): Promise<string> {
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secret),
    { name: 'HMAC', hash: 'SHA-512' },
    false,
    ['sign'],
  );

  const signature = await crypto.subtle.sign(
    'HMAC',
    key,
    new TextEncoder().encode(payload),
  );

  return Array.from(new Uint8Array(signature))
    .map((byte) => byte.toString(16).padStart(2, '0'))
    .join('');
}

serve(async (req) => {
  if (req.method != 'POST') {
    return new Response(
      JSON.stringify({ error: 'Method not allowed' }),
      { status: 405, headers: jsonHeaders },
    );
  }

  const paystackSecret = Deno.env.get('PAYSTACK_SECRET_KEY');
  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const supabaseServiceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');

  if (!paystackSecret || !supabaseUrl || !supabaseServiceRoleKey) {
    return new Response(
      JSON.stringify({ error: 'Missing required environment variables.' }),
      { status: 500, headers: jsonHeaders },
    );
  }

  const rawBody = await req.text();
  const incomingSignature = req.headers.get('x-paystack-signature') ?? '';
  const expectedSignature = await hmacSha512Hex(paystackSecret, rawBody);

  if (!timingSafeEqual(incomingSignature, expectedSignature)) {
    return new Response(
      JSON.stringify({ error: 'Invalid signature.' }),
      { status: 401, headers: jsonHeaders },
    );
  }

  let payload: PaystackWebhook;
  try {
    payload = JSON.parse(rawBody) as PaystackWebhook;
  } catch (_) {
    return new Response(
      JSON.stringify({ error: 'Invalid JSON payload.' }),
      { status: 400, headers: jsonHeaders },
    );
  }

  const event = payload.event ?? '';
  const reference = payload.data?.reference;
  const orderCode = payload.data?.metadata?.order_code;

  if (!reference && !orderCode) {
    return new Response(
      JSON.stringify({ error: 'Missing reference and order_code.' }),
      { status: 400, headers: jsonHeaders },
    );
  }

  const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  });

  const paymentStatus =
    event == 'charge.success'
      ? 'paid'
      : event == 'charge.failed'
      ? 'failed'
      : event == 'charge.abandoned'
      ? 'abandoned'
      : payload.data?.status == 'success'
      ? 'paid'
      : payload.data?.status == 'failed'
      ? 'failed'
      : 'pending';

  const orderStatus = paymentStatus == 'paid'
    ? 'Preparing'
    : paymentStatus == 'failed' || paymentStatus == 'abandoned'
    ? 'Payment Failed'
    : 'Awaiting Payment';

  const updates = {
    payment_status: paymentStatus,
    status: orderStatus,
    payment_reference: reference,
  };

  let updatedRows: Array<{ id: string }> = [];

  if (reference) {
    const { data, error } = await supabase
      .from('orders')
      .update(updates)
      .eq('payment_reference', reference)
      .select('id');

    if (error) {
      return new Response(
        JSON.stringify({ error: error.message }),
        { status: 500, headers: jsonHeaders },
      );
    }
    updatedRows = data ?? [];
  }

  if (updatedRows.length == 0 && orderCode) {
    const { data, error } = await supabase
      .from('orders')
      .update(updates)
      .eq('order_code', orderCode)
      .select('id');

    if (error) {
      return new Response(
        JSON.stringify({ error: error.message }),
        { status: 500, headers: jsonHeaders },
      );
    }
    updatedRows = data ?? [];
  }

  return new Response(
    JSON.stringify({
      ok: true,
      event,
      payment_status: paymentStatus,
      order_status: orderStatus,
      updated_rows: updatedRows.length,
    }),
    { status: 200, headers: jsonHeaders },
  );
});
