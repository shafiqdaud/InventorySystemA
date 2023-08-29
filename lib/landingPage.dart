import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_system/contants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:inventory_system/navigation/navigation_page.dart';

class landingPage extends StatelessWidget {
  const landingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController textController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, height * .25, height * .35, 0),
          child: Column(
            children: [
              const Text('Welcome To AN Trades Inventory System', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 25,),
              const Text('Please Login to Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 25,),
              SizedBox(
                width: width * .5,
                child:  TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter User Name',
                  ),

                ),
              ),
              Padding(
                padding: const  EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: width * .5,
                  child:  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Password',
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: width * .15,
                  child: ElevatedButton(
                      onPressed:  (){
                        var data =  {
                          'email': textController.text,
                          'password': passwordController.text
                        };
                        print(jsonEncode(<String,String>{
                          'email': textController.text,
                          'password': passwordController.text
                        }),);
                        var url = 'http://127.0.0.1:8080/user/login';
                        final Future<http.Response> response =  http.post(
                            Uri.parse(url),
                            body: jsonEncode(<String,String>{
                              'email': textController.text,
                              'password': passwordController.text
                        }),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const navigation_page();
                        }));
                      },
                      child: const Text('Log In')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
