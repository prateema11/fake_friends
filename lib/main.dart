import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
void main() {
  runApp(
    MaterialApp(
      theme:ThemeData(
        primarySwatch:Colors.red
      ),
      home: HomePage()
    )
  );
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;
  Future getData() async{
    Uri apiUrl = Uri.parse('https://reqres.in/api/users');
    http.Response response= await http.get(apiUrl);
    data =json.decode(response.body);
    setState(() {
      userData= data['data'];
    });
    debugPrint(userData.toString());
  }
  // void showStuff()async{
  //    Map data=getData(data,userData);
  //    print(data.toString());
  // }
 void initState(){
   super.initState();
   getData();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title:Text('Fake Friends'),
        centerTitle: true,
        backgroundColor:Colors.green
      ),
      
      body: ListView.builder(
        itemBuilder:(BuildContext context,int index){
          return Card(
            child: new Row(
              children:<Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(userData[index]['avatar']),
                ),
                new Text('${userData[index]['first_name']} ${userData[index]['last_name']}')
              ]
            ),
          );
        } ,
        itemCount: userData==null ? 0 : userData.length),
    );
  }
}
