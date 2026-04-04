import { serve } from 'https://deno.land/std@0.224.0/http/server.ts';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

type InitPayload = {
  email: string;
  amount: number;
  callback_url?: string;
  metadata?: Record<string, unknown>;
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const secretKey = Deno.env.get('PAYSTACK_SECRET_KEY');
    if (!secretKey) {
      return new Response(
        JSON.stringify({ error: 'PAYSTACK_SECRET_KEY is not configured.' }),
        {
          status: 500,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        },
      );
    }

    const body = (await req.json()) as InitPayload;
    if (!body.email || !body.amount) {
      return new Response(
        JSON.stringify({ error: 'email and amount are required.' }),
        {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        },
      );
    }

    const paystackResponse = await fetch('https://api.paystack.co/transaction/initialize', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${secretKey}`,
      },
      body: JSON.stringify({
        email: body.email,
        amount: body.amount,
        callback_url: body.callback_url,
        metadata: body.metadata,
      }),
    });

    const paystackJson = await paystackResponse.json();

    if (!paystackResponse.ok || paystackJson.status !== true) {
      return new Response(
        JSON.stringify({
          error: 'Paystack initialize failed',
          details: paystackJson,
        }),
        {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        },
      );
    }

    return new Response(
      JSON.stringify({
        authorization_url: paystackJson.data.authorization_url,
        access_code: paystackJson.data.access_code,
        reference: paystackJson.data.reference,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      },
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ error: String(error) }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      },
    );
  }
});
