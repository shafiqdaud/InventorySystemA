import 'package:flutter/material.dart';
import 'package:inventory_system/landingPage.dart';
import 'package:http/http.dart' as http;

void main() async{
  // var url = 'http://127.0.0.1:8080/user/get';
  // final http.Response response = await http.get(Uri.parse(url));
  // print(response.statusCode);
  runApp(const mainfile());

}

class mainfile extends StatelessWidget {
  const mainfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: landingPage(),
    );
  }
}
