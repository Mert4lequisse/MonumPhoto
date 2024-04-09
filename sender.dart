import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendResultToEmail( String emailAddress, bool isCostly) async {

  Uri emailServiceUrl = Uri.parse('https://back.mert4lequisse:9999/send-email');

  String resultMessage = isCostly ? "" : ""; // TODO - recup en param

  try {
    final response = await http.post(
      emailServiceUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'to': emailAddress,
        'subject': 'analyse cout',
        'message': resultMessage,
      }),
    );

    if (response.statusCode == 200) {
   
      print("Email sent successfully.");
    } else {

      print("not good: ${response.body}");
    }
  } catch (exception) {
    print("Failed to send the email. Exception: $exception");

  }
}
