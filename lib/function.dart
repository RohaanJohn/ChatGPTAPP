import 'package:http/http.dart' as http;
import 'dart:io';

uploadImage(String question) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("https://chatgptapi2.up.railway.app/accounts/ask"));
  request.fields['title'] = "dummy";
  request.headers['Referer'] = "https://chatgptapiapi2.up.railway.app/";
  request.fields['question'] = question;

  var response = await request.send();

  var responseData = await response.stream.toBytes();
  var result = String.fromCharCodes(responseData);
  return result;
}
