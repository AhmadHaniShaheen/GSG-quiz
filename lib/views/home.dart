import 'package:api_qize/models/image.dart';
import 'package:api_qize/models/qoute.dart';
import 'package:api_qize/service/capture_image.dart';
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
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    futureAlbum = Qoute().fetchAlbum();

    futureImage = ImageProv().fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await capturePng(context, globalKey);
        },
        label: const Text('Take screenshot'),
        icon: const Icon(Icons.share_rounded),
      ),
      body: FutureBuilder(
        future: futureImage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RepaintBoundary(
              key: globalKey,
              child: Container(
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
                              child: Text(
                                snapshot.data!.contant,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
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
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 235, 154, 208)
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 9.0,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    futureAlbum = Future.delayed(
                                        const Duration(seconds: 1),
                                        () => Qoute().fetchAlbum());
                                    futureImage = Future.delayed(
                                        const Duration(seconds: 1),
                                        () => ImageProv().fetchImage());
                                  });
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
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
