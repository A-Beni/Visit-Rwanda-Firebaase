// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:visit_rwanda/details.dart';
import 'package:visit_rwanda/explore_page.dart';
import 'package:visit_rwanda/trip_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/explore': (context) => const ExplorePage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ExplorePage(),
    TripPage(),
    Center(
      child: Text('Profile Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('A'),
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String imageUrl = '';
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';
  String imageUrl5 = '';

  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('cabin.jpeg');
    final ref1 = storage.ref().child('mountain.jpeg');
    final ref2 = storage.ref().child('cabin.jpeg');
    final ref3 = storage.ref().child('le-marara.jpeg');
    final ref4 = storage.ref().child('cleo.jpeg');
    final ref5 = storage.ref().child('le-marara.jpeg');
    final url = await ref.getDownloadURL();
    final url1 = await ref1.getDownloadURL();
    final url2 = await ref2.getDownloadURL();
    final url3 = await ref3.getDownloadURL();
    final url4 = await ref4.getDownloadURL();
    final url5 = await ref5.getDownloadURL();
    setState(() {
      imageUrl = url;
      imageUrl1 = url1;
      imageUrl2 = url2;
      imageUrl3 = url3;
      imageUrl4 = url4;
      imageUrl5 = url5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SearchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child:
                    const Text('See all', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          const Text(
            'Get discount on all-time favorite\ndestinations',
            style:
                TextStyle(fontSize: 16, color: Color.fromARGB(255, 15, 15, 15)),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (imageUrl.isNotEmpty)
                  DestinationCard(
                    title: 'Cabin',
                    weeks: '3 weeks',
                    discount: '10%',
                    description:
                        'Explore GOA with amazing discounts, book your adventure today!',
                    imageUrl: imageUrl,
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 10, width: 10),
                if (imageUrl1.isNotEmpty)
                  DestinationCard(
                    title: 'Mountain Sabyinyo',
                    weeks: '6 weeks',
                    discount: '25%',
                    description:
                        'Explore Andaman and Nicobar islands with amazing discounts, book your adventure today!',
                    imageUrl: imageUrl1,
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 10, width: 10),
                if (imageUrl2.isNotEmpty)
                  DestinationCard(
                    title: 'Cabin',
                    weeks: '3 weeks',
                    discount: '10%',
                    description:
                        'Explore GOA with amazing discounts, book your adventure today!',
                    imageUrl: imageUrl2,
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All time favorite',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child:
                    const Text('See all', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          const Text(
            'Wanna go on a trip today!',
            style:
                TextStyle(fontSize: 16, color: Color.fromARGB(255, 27, 26, 26)),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (imageUrl3.isNotEmpty)
                  DestinationCard(
                    title: 'Le Marara',
                    weeks: '3 weeks',
                    discount: '5%',
                    description:
                        'Explore the beauty of Le Marara, book your adventure today!',
                    imageUrl: imageUrl3,
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 10, width: 10),
                if (imageUrl4.isNotEmpty)
                  DestinationCard(
                    title: 'Cleo Hotel',
                    weeks: '4 weeks',
                    discount: '15%',
                    description:
                        'Enjoy a luxurious stay at Cleo Hotel, book your adventure today!',
                    imageUrl: imageUrl4,
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 10, width: 10),
                if (imageUrl5.isNotEmpty)
                  DestinationCard(
                    title: 'Le Marara',
                    weeks: '3 weeks',
                    discount: '5%',
                    description:
                        'Explore the beauty of Le Marara, book your adventure today!',
                    imageUrl: imageUrl5,
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
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

class DestinationCard extends StatelessWidget {
  final String title;
  final String weeks;
  final String discount;
  final String description;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.title,
    required this.weeks,
    required this.discount,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              title: title,
              description: description,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 200, // Adjusted width to fit better on screen
        height: 200, // Adjusted height to fit better on screen
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    weeks,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
