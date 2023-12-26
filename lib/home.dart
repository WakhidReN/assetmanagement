import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:provider/provider.dart';
// import 'package:utswakhid1/scanqr.dart';
// import 'package:utswakhid1/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({super.key});

  Future<List<dynamic>> fetchAssets() async {
    var url = Uri.parse('http://localhost:8084/assets');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to fetch assets. Error: ${response.statusCode}');
        throw Exception('Failed to fetch assets. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching assets: $error');
      throw Exception('Error fetching assets: $error');
    }
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Management Bosston Gym'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> assets = snapshot.data ?? [];
            return buildContent(assets,context);
          }
        },
      ),
    );
  }

    Widget buildContent(List<dynamic> assets, context) {
    return Column(
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
        SizedBox(height: 12), // Add some spacing
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
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
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
            itemCount: assets.length,
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
                              '${assets[index]['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('${assets[index]['kategori']}'),
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
                              'id': assets[index]['id'],
                              'name': assets[index]['name'],
                              'kategori': assets[index]['kategori'],
                            },
                          );
                        },
                        child: Text('Detail'),
                      ),
                    ],
                  ),
                  // onTap: () {
                  //   print('Asset Details: ${assets[index]}');
                  // },
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
    );
  }
}