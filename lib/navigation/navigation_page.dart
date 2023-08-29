import 'package:flutter/material.dart';
import 'package:inventory_system/inventory/inventory_page.dart';
import 'package:inventory_system/landingPage.dart';
import '../contants.dart' as Constants;


class navigation_page extends StatefulWidget {
  const navigation_page({Key? key}) : super(key: key);

  @override
  State<navigation_page> createState() => _navigation_pageState();
}

class _navigation_pageState extends State<navigation_page> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(Constants.title),),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * .25),
              child: SizedBox(
                  height: height * .15,
                  width:  width * .25,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const inventory_page();
                        }));
                      },
                      child: const Text(Constants.inventory))
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: SizedBox(
                  height: height * .15,
                  width:  width * .25,
                  child: ElevatedButton(onPressed: (){}, child: const Text(Constants.buySell))
              ),
            ),          ],
        )
      ),
    );
  }
}
