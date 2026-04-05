import 'dart:convert';
import 'package:http/http.dart' as http;

class AiAgentService {
  final String supabaseUrl;
  final String anonKey;
  AiAgentService(this.supabaseUrl, this.anonKey);

  Future<String> askAdminAgent(List<Map<String, String>> messages) async {
    final url = Uri.parse('$supabaseUrl/functions/v1/admin-ai-agent');
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $anonKey',
      },
      body: jsonEncode({'messages': messages}),
    );
    final data = jsonDecode(res.body);
    return data['reply'] as String;
  }
}
