import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> assets = [];
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    var url = Uri.parse('http://localhost:8084/assets');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          assets = json.decode(response.body);
          searchResults = List.from(assets);
        });
      } else {
        print('Failed to fetch assets. Error: ${response.statusCode}');
        throw Exception(
            'Failed to fetch assets. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching assets: $error');
      throw Exception('Error fetching assets: $error');
    }
  }

  void updateSearchResults(String query) {
    setState(() {
      searchResults = assets
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Management Bosston Gym'),
      ),
      body: Column(
        children: [
          // Carousel Slider
          Container(
            width: double.infinity,
            height: 180,
            child: CarouselSlider(
              items: [
                Image.network(
                  'https://images.unsplash.com/photo-1596357395104-ba989e72b5ec?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                  width: 360.0,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1596357395217-80de13130e92?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                  width: 360.0,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                  width: 360.0,
                ),
              ],
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
            ),
          ),
          SizedBox(height: 12),
          // Search TextField
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 219, 219, 219),
                  width: 0.5,
                ),
              ),
              width: 360,
              height: 44,
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  updateSearchResults(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print('Search Button Clicked');
                    },
                  ),
                ),
              ),
            ),
          ),
          // Asset Cards
          Expanded(
            child: ListView.separated(
              itemCount: searchResults.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${searchResults[index]['name']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${searchResults[index]['kategori']}'),
                            ],
                          ),
                        ),
                        // Detail button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: {
                                'id': searchResults[index]['id'],
                                'name': searchResults[index]['name'],
                                'kategori': searchResults[index]['kategori'],
                              },
                            );
                          },
                          child: Text('Detail'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/scan',
                    );
                  },
                  child: Text('Scan QR'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/scan',
                    );
                  },
                  child: Text('Scan Barcode'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
