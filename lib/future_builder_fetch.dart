import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderFetch extends StatelessWidget {
  fetchMovies() async {
    var url = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US"));
        return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191826),
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'MOVIES',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xff191826),
      ),
      body: FutureBuilder(
          future: fetchMovies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(
                              "https://image.tmdb.org/t/p/w500${snapshot.data[index]['poster_path']}"),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0,),
                            Text(
                              snapshot.data[index]["original_title"],
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              snapshot.data[index]["release_date"],
                              style: const TextStyle(color: Color(0xff868597)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              child: Text(
                                snapshot.data[index]["overview"],
                                style: const TextStyle(color: Color(0xff868597)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}