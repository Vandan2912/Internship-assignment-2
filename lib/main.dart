import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? data;
  var news_length;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http
        .get(Uri.parse("https://inshorts.deta.dev/news?category=science"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        news_length = jsonDecode(data!)[
            'data']; //get all the data from json string superheros// just printed length of data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Science News"),
      ),
      body: ListView.builder(
        itemCount: news_length == null ? 0 : news_length.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            color: Colors.white70,
            child: Column(
              children: [
                Image.network(jsonDecode(data!)['data'][index]['imageUrl'],
                    fit: BoxFit.fill,
                    height: 300,
                    width: double.infinity,
                    alignment: Alignment.center),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                    jsonDecode(data!)['data'][index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(jsonDecode(data!)['data'][index]['content']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
