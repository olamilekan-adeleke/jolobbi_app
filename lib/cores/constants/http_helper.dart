import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<Map<String, dynamic>> get(String uri) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      http.Response response = await http.get(Uri.parse(uri), headers: headers);

      final Map<String, dynamic> result = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      } else {
        throw result['msg'];
      }
    } on FormatException catch (_) {
      throw 'Unable To Format Data!';
    } on SocketException catch (_) {
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<Map<String, dynamic>> post({
  required  String uri,
  required  Map<String, dynamic> body,
  }) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      http.Response response = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: json.encode(body),
      );

      final Map<String, dynamic> result = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      } else {
        throw result['msg'];
      }
    } on FormatException catch (_) {
      throw 'Unable To Format Data!';
    } on SocketException catch (_) {
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }
}
