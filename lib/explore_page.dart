// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExplorePage(),
    );
  }
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final storage = FirebaseStorage.instance;
  List<Map<String, String>> cities = [];
  List<Map<String, String>> adventures = [];
  bool isLoading = true; // Add a loading state variable

  @override
  void initState() {
    super.initState();
    fetchCityImages();
    fetchAdventureImages();
  }

  // Fetch city images
  Future<void> fetchCityImages() async {
    final List<Map<String, String>> cityDetails = [
      {'name': 'Kigali', 'path': 'kigali.jpeg'},
      {'name': 'Musanze', 'path': 'musanze.jpeg'},
      {'name': 'Rubavu', 'path': 'rubavu.jpeg'},
      {'name': 'Kibeho', 'path': 'kibeho.jpeg'},
      {'name': 'Muhanga', 'path': 'muhanga.jpeg'},
      {'name': 'Rwesero', 'path': 'rwesero.jpeg'},
      {'name': 'Kamembe', 'path': 'kamembe.jpg'},
      {'name': 'Vision City', 'path': 'vision_city.jpg'},
    ];

    try {
      // Fetch city images asynchronously
      final fetchedCities = await Future.wait(cityDetails.map((city) async {
        final url = await storage.ref().child(city['path']!).getDownloadURL();
        return {'name': city['name']!, 'image': url};
      }));

      // Update state with fetched data
      if (mounted) {
        setState(() {
          cities = fetchedCities;
        });

        // Check if all data has been fetched
        checkIfAllDataFetched();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false; // Set loading to false on error
        });
      }
    }
  }

  // Fetch adventure images
  Future<void> fetchAdventureImages() async {
    final List<Map<String, String>> adventureDetails = [
      {
        'title': 'Hiking',
        'path': 'hiking.jpeg',
        'discount': '20%',
        'duration': '4 weeks'
      },
      {
        'title': 'Backpack',
        'path': 'backpack.jpg',
        'discount': '30%',
        'duration': '3 Months'
      },
      {
        'title': 'Hot Air Balloon',
        'path': 'hot-airballon.jpeg',
        'discount': '8%',
        'duration': '2 weeks'
      },
      {
        'title': 'Kayaking',
        'path': 'kayaking.jpeg',
        'discount': '5%',
        'duration': '1 week'
      },
    ];

    try {
      // Fetch adventure images asynchronously
      final fetchedAdventures =
          await Future.wait(adventureDetails.map((adventure) async {
        final url =
            await storage.ref().child(adventure['path']!).getDownloadURL();
        return {
          'title': adventure['title']!,
          'image': url,
          'discount': adventure['discount']!,
          'duration': adventure['duration']!,
        };
      }));

      // Update state with fetched data
      if (mounted) {
        setState(() {
          adventures = fetchedAdventures;
        });

        // Check if all data has been fetched
        checkIfAllDataFetched();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false; // Set loading to false on error
        });
      }
    }
  }

  // Check if all data has been fetched
  void checkIfAllDataFetched() {
    if (cities.isNotEmpty && adventures.isNotEmpty) {
      setState(() {
        isLoading = false; // Data has been fetched, stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Display CircularProgressIndicator when loading
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchBar(),
                    const SizedBox(height: 20),
                    const Text(
                      'Explore Cities',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Explore different cities in your budget',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          return CityCard(
                            image: city['image']!,
                            name: city['name']!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adventure',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Different adventure trips!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: adventures.length,
                      itemBuilder: (context, index) {
                        final adventure = adventures[index];
                        return AdventureCard(
                          discount: adventure['discount']!,
                          image: adventure['image']!,
                          title: adventure['title']!,
                          duration: adventure['duration']!,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CityCard extends StatelessWidget {
  final String image;
  final String name;

  const CityCard({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AdventureCard extends StatelessWidget {
  final String discount;
  final String image;
  final String title;
  final String duration;

  const AdventureCard({
    super.key,
    required this.discount,
    required this.image,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  color: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    discount,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            duration,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211, 207, 207),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
