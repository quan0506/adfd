import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ui_adfd/screens/OtherScreen.dart';
import '../data/model/Place_model.dart';
import '../data/service/Place_Repository.dart';

class PlaceScreen extends StatefulWidget {
  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  late Future<List<Place>> places;
  int _selectedIndex = 0;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    places = PlaceRepository().fetchPlaces();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtherScreen()),
    );
  }

  final Set<int> _favorites = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: AppBar(
            backgroundColor: Color(0x8F5953FF),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hi Guy !!!\nWhat are you going next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 0),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Search your addreess",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFD29E),
                            minimumSize: Size(120, 50),
                          ),
                          child: Icon(Icons.apartment,color: Color(0xFF835113)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Hotel',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFFF9E9E),
                            minimumSize: Size(120, 50),
                          ),
                          child: Icon(Icons.flight,color: Color(0xFF8C3535)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Flight',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD9FFD3),
                            minimumSize: Size(120, 50),
                          ),
                          child: Icon(Icons.room_preferences, color: Color(
                              0x331C2E18)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'All',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
          Text(
            'Popular Destinations',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: places,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Places Found'));
                } else {
                  final filteredPlaces = snapshot.data!
                      .where((place) =>
                      place.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();

                  return GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];
                      final isFavorite = _favorites.contains(index);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            place.image.isNotEmpty
                                ? Image.memory(
                              base64Decode(place.image),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                                : Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.image,
                                size: 120,
                                color: Colors.grey[600],
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black54, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '${place.rate}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.yellow,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isFavorite) {
                                      _favorites.remove(index);
                                    } else {
                                      _favorites.add(index);
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: isFavorite ? Colors.pink : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaceScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtherScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtherScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtherScreen()),
              );
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
