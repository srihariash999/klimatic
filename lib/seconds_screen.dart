import 'package:flutter/material.dart';


class ChangeCity extends StatefulWidget {
  ChangeCity({Key key}) : super(key: key);

  @override
  _ChangeCityState createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {

var _cityChangeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
       child: MaterialApp(
         home: Scaffold(
           appBar: AppBar(
             title: Text("Change city"),
             centerTitle: true,
             backgroundColor: Colors.redAccent,
           ),
           body: Column(
             children: <Widget>[
              
              TextField(
                controller: _cityChangeController,
                decoration: InputDecoration(
                  labelText: "Please enter name of the city",
                ),
                
              ),

              SizedBox(height: 30.0,),

              FlatButton(
                child: Text("Save and go back"),
                color: Colors.redAccent,
                onPressed: (){
                  Navigator.pop(context, {
                            'enter': _cityChangeController.text.toLowerCase()
                         });
                },
              )

             ],
           ),
         ),
       ),
    );
  }
}
