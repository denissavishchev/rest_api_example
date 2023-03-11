import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> pokemons = [];

  void _fetchData() async {
    const url = 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=200';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    print(json);
    setState(() {
      pokemons = json['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            final name = pokemon['name'];

            final imageUrl = pokemon['url'];
            print(imageUrl);
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(name),
              // subtitle: Text(name.toString()),
              // trailing: ClipRRect(
              //   borderRadius: BorderRadius.circular(100),
              //   child: Image.network(image),
              // ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        child: const Icon(Icons.data_exploration_outlined),
      ),
    );
  }
}
