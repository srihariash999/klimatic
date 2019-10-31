import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:klimatic/seconds_screen.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

 


class Klimatic extends StatefulWidget {
  Klimatic({Key key}) : super(key: key);

  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic>  {


  String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator
        .of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) { //change to Map instead of dynamic for this to work
      return new ChangeCity();
    }));

    if ( results != null && results.containsKey('enter')) {
       _cityEntered = results['enter'];
      // debugPrint("From First screen" + _cityEntered.toString());
    }
     

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    
      appBar: AppBar( title: Text('Klimatic' ),
      centerTitle: true, 
      backgroundColor: Colors.orangeAccent,
      actions: <Widget>[

        IconButton(
           icon: Icon(Icons.menu),
           splashColor: Colors.blueGrey,
           onPressed: (){
             _goToNextScreen(context);
           },
        )
       
      ],
      ),
      
      body: Stack(

        children: <Widget>[

          Center(
           child: Image.asset('images/umbrella.png', 
           fit: BoxFit.fill,
           height: 1920,
           )
          ),

          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 10.0, right: 12.0),
            child: Text(_cityEntered == null ? defaultCity.toUpperCase() : _cityEntered.toUpperCase(), style: kCityTextStyle,),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 120.0, right: 12.0),
            child: Image.asset('images/light_rain.png'),
          ),

          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 10.0, right: 12.0),
            child: updateWeatherWidget(_cityEntered == null ? defaultCity : _cityEntered),
          ),


        ],
        
      ),
    );



}


Future <Map> fetchData(String defaultCity, String apiid) async {
      
     String  url = "http://api.openweathermap.org/data/2.5/weather?q=$defaultCity&appid=$apiid&units=metric";

      http.Response response = await http.get(url);
          
        Map poo = json.decode(response.body);
        //print(poo.toString());
 return  poo;
   
}


Widget updateWeatherWidget(String city) {

return FutureBuilder(

future: fetchData(city, apiid),

builder: (BuildContext context, AsyncSnapshot snapshot){
  if (snapshot.hasData)
  {
    Map content = snapshot.data;
    //print(content['main']['temp'].toString());
    return Container(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ListTile(
            title: Text("Temp: "+(content['main']['temp'].toString()),
             style:  kTempTextStyle,),
          ),

          ListTile(
            title: Text("min:" +(content['main']['temp_min'].toString())+" max:"+(content['main']['temp_max'].toString()),
              style:  kSmallerTextStyle),
          ),

          ListTile(
            title: Text("Hum: "+(content['main']['humidity'].toString())+"%",
              style:  kTempTextStyle,),
          ),

        ],
      ),
    );
  }

  else{
    return Container();
  }


},



);

}



}