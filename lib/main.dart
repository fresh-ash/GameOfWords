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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    list = ["Empty"];
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
          ListView(
            children: [
              Card(
                color: Colors.limeAccent,
                child: ListTile(
                  title: Text('Adj & Noun'),
                  subtitle: Text('Get random pair adjectives & nouns'),
                  onTap: () => pressButton("/adj&noun/"),
              ),
            ),
              Card(
                color: Colors.yellowAccent,
                child: ListTile(
                  title: Text('Verb & Noun'),
                  subtitle: Text('Get random pair verbs & nouns'),
                  onTap: () => pressButton("/verb&noun/"),

                ),
              ),
              Card(
                color: Colors.amberAccent,
                child: ListTile(
                  title: Text('Verb & Adverb'),
                  subtitle: Text('Get random pair verbs & adverbs'),
                  onTap: () => pressButton("/verb&adverb/"),
                ),
              ),
              Card(
                color: Colors.amber,
                child: ListTile(
                  title: Text('Noun & Noun'),
                  subtitle: Text('Get random pair nouns & nouns'),
                ),
              )

        ],
      ),
    );
  }

  Widget buildCreativeButtons(){

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: "Game of words",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Game of words'),
        ),

        body: Center(
          child: Row(
            children: [
              _buildButtons(),
              Expanded(
                child:
                ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        height: 30,
                        child: Center(
                          child: Text('${list[index]}'),
                        ),
                      );
                    },
                ),
              ),
            ],
          ),
        ),



      ),



    );

  }
}
