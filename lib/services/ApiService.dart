// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> callablefunc(
    String BaseUrl,
    bool isGet,
    String endpoint,
    Map<String, dynamic> parameters,
    void Function(dynamic jsonResponse) onSuccess,
    void Function(String error) onFailure,
  ) async {
    try {
      //var baseUrl = ApiConstants.baseUrl_Main;
      var url = Uri.parse('$BaseUrl$endpoint');

      http.Response response;

      if (isGet) {
        var uri =
            Uri.parse('$BaseUrl$endpoint').replace(queryParameters: parameters);
        response = await http.get(uri);
        print("GET Request URL: $uri");
      } else {
        // POST request
        var body = json.encode(parameters);
        response = await http.post(
          url,
          body: body,
          headers: {'Content-Type': 'application/json'},
        );
        print("POST Request URL: $url");
        print("POST Request Body: $body");
      }

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic jsonResponse = json.decode(response.body);
        onSuccess(jsonResponse);
      } else {
        onFailure("API Call Failed: ${response.statusCode}");
      }
    } catch (e) {
      // print("Exception in API Call: $e");
      onFailure("API Call Exception: $e");
    }
  }
}
