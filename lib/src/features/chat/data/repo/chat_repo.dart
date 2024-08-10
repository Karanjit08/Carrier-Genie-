

import 'dart:convert';

import '../../domain/chat_message_model.dart';
import 'package:http/http.dart' as http;

class ChatRepo{
  static Future<String> ChatResponseRepo(List<ChatMessageModel> generatedMessages)async{
    final String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=AIzaSyBBSWyPUrsJJd3N5pOWg3-JrVPRp1OzIhk";
    // Convert the generatedMessages list to a list of maps
    List<Map<String, dynamic>> messagesMap = generatedMessages.map((e) => e.toMap()).toList();

    // Create the request body
    Map<String, dynamic> requestBody = {
      "contents": messagesMap,
      "generationConfig": {
        "temperature": 0.9,
        "topK": 1,
        "topP": 1,
        "maxOutputTokens": 2048,
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        }
      ]
    };

    // Send the HTTP POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('RESPONSE STATUS CODE: ${response.statusCode}');
      // Decode the response body
      Map<String, dynamic> responseBody = json.decode(response.body);

      // Handle the response as needed
      // Print the entire response body to understand its structure
      // Adjust the return statement based on the actual response structure
      // return responseBody.toString(); // Adjust this based on the actual key
      String modelResponse = responseBody['candidates'][0]['content']['parts'][0]['text'];
      return modelResponse.toString();
    } else {
      print('RESPONSE STATUS CODE: ${response.statusCode}');
      return 'Error: ${response.statusCode} ${response.reasonPhrase}';
    }
  }
}