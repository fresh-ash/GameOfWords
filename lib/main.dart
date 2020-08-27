import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'data/Message.dart';

Future<Message> fetchMessage(String url) async{
  final response = await http.get(url);
  if (response.statusCode == 200){
    return Message.fromJson(json.decode(response.body));
  }
  else{
    throw Exception ('FAIL!');
  }
}


void main() {
  runApp(MyApp());
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Game of words',

      home: MyHomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String baseURL = 'https://game-of-words.herokuapp.com/gameofwords';
  List<String>  list;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    list = ["There", "will     be", "result!", "Please, try to do something!"];
  }

  void pressButton(String url) async {

      setState(() {
        list = ["Please wait..."];
      });
     var message = await fetchMessage(baseURL + url);

     setState(() {
       list = message.mess.split("\n");
     });
    }

  Expanded _buildButtons(){
        return Expanded(
        child:
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            shrinkWrap: true,
            children: [
              Card(
                shadowColor: Colors.white,
                color: Colors.blue,
                child:
                Center(
                  child:
                ListTile(
                  title: Stack(
                    children: <Widget>[
                      Text("Adj & Noun",
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Adj & Noun",
                        style: TextStyle(
                          fontSize: 20,
                          color:  Colors.white,
                        ),
                      )
                    ],
                  ),
                  subtitle: Text('Get pairs of adjectives & nouns'),
                  onTap: () => pressButton("/adj&noun/"),
              ),
            ),),
              Card(
                shadowColor: Colors.white,
                color: Colors.blue,
                child:
                Center(
                  child:
                ListTile(
                  title: Stack(
                    children: <Widget>[
                      Text("Verb & Noun",
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Verb & Noun",
                        style: TextStyle(
                          fontSize: 20,
                          color:  Colors.white,
                        ),
                      )
                    ],
                  ),
                  subtitle: Text('Get pairs of verbs & nouns'),
                  onTap: () => pressButton("/verb&noun/"),

                ),
              ),),
              Card(
                shadowColor: Colors.white,
                color: Colors.blue,
                child:
                Center(
                  child:
                ListTile(
                  title: Stack(
                    children: <Widget>[
                      Text("Verb & Adverb",
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Verb & Adverb",
                        style: TextStyle(
                          fontSize: 20,
                          color:  Colors.white,
                        ),
                      )
                    ],
                  ),
                  subtitle: Text('Get pairs of verbs & adverbs'),
                  onTap: () => pressButton("/verb&adverb/"),
                ),
                ),),
              Card(
                shadowColor: Colors.white,
                color: Colors.blue,
                child:
                Center(
                  child:
                ListTile(
                  title: Stack(
                    children: <Widget>[
                      Text("Noun & Noun",
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Noun & Noun",
                        style: TextStyle(
                          fontSize: 20,
                          color:  Colors.white,
                        ),
                      )
                    ],
                  ),
                  subtitle: Text('Get pairs of nouns'),
                ),
              ),),

        ],
      ),
    );
  }

  Container _myAppBar(){
    return Container(

            height: 200,
           color: Colors.black,
          /* decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage("assets/images/top.jpg"),
               fit: BoxFit.cover,
             )
           ),*/
          child:
              Center(
    child:
            Column(
              
              children: [
                  Spacer(),
                  Stack(
                    children: <Widget>[
                      Text("Game of WORDS",
                      style: TextStyle(
                        foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                      ),
                      Text(
                        "Game of WORDS",
                        style: TextStyle(
                          fontSize: 40,
                          color:  Colors.black,
                        ),
                      )
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.all(15),

                    child:
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Only one word",
                      hintStyle: TextStyle(color: Colors.white),

                      fillColor: Colors.indigo.withOpacity(0.4),
                      filled: true,


                    ),
                  ),
                  ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child:
                    Text(" -          20         + ",
                    style: TextStyle(color: Colors.orange, fontSize: 20,),)
                    ),
              ],
            ),
              ),
         );
  }

  Expanded _getContent(){
    return Expanded(
      child:
      Container(
        margin: const EdgeInsets.all(5),
        color: Colors.black,
        child:
        ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              height: 35,
              child: Center(
                child: Text('${list[index]}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);

    return MaterialApp(
        title: "Game of words",
        debugShowCheckedModeBanner: false,
        home:
        Scaffold(

          body:
          Container(
            color: Colors.black,
            child:
            Center(

              child:
              Column(
                children: <Widget> [
                  _myAppBar(),
                  _getContent(),
                  Divider(),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
