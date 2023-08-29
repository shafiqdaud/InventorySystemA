import 'package:flutter/material.dart';
import '../contants.dart' as Constants;
class inventory_page extends StatefulWidget {
  const inventory_page({Key? key}) : super(key: key);

  @override
  State<inventory_page> createState() => _inventory_pageState();
}

class _inventory_pageState extends State<inventory_page> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
     appBar: AppBar(
       title: Row(
         children: [
           const Text(Constants.title),
           Padding(
                padding: EdgeInsets.only(left: width * .65 ),
               child: IconButton(
                 onPressed: (){},
                 icon: Icon(Icons.add),tooltip: 'Csv upload Inventory',
               ))
         ],
       ),

     ),
      body: Text('Show inventory')

    );
  }
}
