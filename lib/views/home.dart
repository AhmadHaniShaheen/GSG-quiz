import 'package:api_qize/models/image.dart';
import 'package:api_qize/models/qoute.dart';
import 'package:api_qize/service/image_api.dart';
import 'package:api_qize/service/qoute.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Qoute qoute = Qoute();
  late Future<Album> futureAlbum;
  late Future<ImageApi> futureImage;

  @override
  void initState() {
    futureAlbum = Qoute().fetchAlbum();

    futureImage = ImageProv().fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('');
        },
      ),
      body: FutureBuilder(
        future: futureImage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    snapshot.data!.url,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 9.0,
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                print(snapshot.data!.tag);
                              },
                              child: Text(
                                snapshot.data!.contant,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data!.author,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
