import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/planets.dart';
import 'models/starwards.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<People>> people;
  late Future<List<Planet>> planet;

  @override
  void initState() {
    people = fetchPeople();
    planet = fetchPlanet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            FutureBuilder<List<People>>(
              future: people,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _peopleList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
            FutureBuilder<List<Planet>>(
              future: planet,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _planetList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ));
  }

  Future<List<People>> fetchPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return StarwardsResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _peopleList(List<People> peopleList) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peopleList.length,
        itemBuilder: (context, index) {
          return _peopleItem(peopleList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _peopleItem(People people, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(people.name),
                  Image.network(
                    'https://starwars-visualguide.com/assets/img/characters/' +
                        (index + 1).toString() +
                        '.jpg',
                    width: 120,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<List<Planet>> fetchPlanet() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Widget _planetList(List<Planet> planetList) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: planetList.length,
        itemBuilder: (context, index) {
          return _planetItem(planetList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _planetItem(Planet people, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(people.name),
                  Image.network(
                    'https://starwars-visualguide.com/assets/img/planets/' +
                        (index + 1).toString() +
                        '.jpg',
                    width: 150,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
