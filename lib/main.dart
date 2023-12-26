import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:utswakhid1/scanqr.dart';
import 'package:utswakhid1/detail.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> assets = [];
  bool isLoading = true;

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
          isLoading = false;
        });
      } else {
        print('Failed to fetch assets. Error: ${response.statusCode}');
        isLoading = false;
      }
    } catch (error) {
      print('Error fetching assets: $error');
      isLoading = false;
    }
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Management Bosston Gym'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : assets.isEmpty
              ? Center(child: Text('No assets available.'))
              : Column(
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
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Row(
                                children: [
                                  // Image Network on the left
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
                                      width: 80, // Adjust the width as needed
                                      height: 80, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add some spacing
                                  // Text on the left
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${assets[index]['name']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${assets[index]['kategori']}'),
                                      ],
                                    ),
                                  ),
                                  // Detail button on the right
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle the button click, e.g., navigate to details
                                      print('Detail Button Clicked');
                                    },
                                    child: Text('Detail'),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // You can navigate to a detailed page or perform other actions here
                                // For simplicity, this example just prints the asset details
                                print('Asset Details: ${assets[index]}');
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // Two buttons below the card
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle the "Scan QR" button click
                              print('Scan QR Button Clicked');
                            },
                            child: Text('Scan QR'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle the "Scan Barcode" button click
                              print('Scan Barcode Button Clicked');
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







// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//     List<dynamic> assets = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchassets();
//   }

//   Future<void> fetchassets() async {
//     var url = Uri.parse('http://localhost:8084/assets');
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       setState(() {
//         assets = json.decode(response.body);
//       });
//     } else {
//       print('Failed to fetch assets. Error: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Asset Management'),
//       ),
//       body: ListView.builder(
//         itemCount: assets.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 5,
//             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             child: ListTile(
//               title: Text(
//                 '${assets[index]['name']}',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Tahun: ${assets[index]['kategori']}'),
//                 ],
//               ),
//               onTap: () {
//                 // You can navigate to a detailed page or perform other actions here
//                 // For simplicity, this example just prints the asset details
//                 print('Asset Details: ${assets[index]}');
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

  // Future<void> fetchassets() async {
  //   var url = Uri.parse('http://localhost:8080/assets');
  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       assets = json.decode(response.body);
  //     });
  //   } else {
  //     print('Failed to fetch assets. Error: ${response.statusCode}');
  //   }
  // }

// Future<List<Map<String, dynamic>>> fetchassets() async {
//   final response = await http.get(Uri.parse('http://localhost:8080/assets'));
  
//   if (response.statusCode == 200) {
//     final List<dynamic> responseData = json.decode(response.body);
//     return responseData.cast<Map<String, dynamic>>();
//   } else {
//     throw Exception('Failed to load asset data');
//   }
// }

//   Future<void> fetchassets() async {
//     var url = Uri.parse('http://localhost:8084/assets');
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       setState(() {
//         assets = json.decode(response.body);
//       });
//     } else {
//       print('Failed to fetch assets. Error: ${response.statusCode}');
//     }
//   }

//   @override
//     Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Asset Management'),
//       ),
//       body: ListView.builder(
//         itemCount: assets.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 5,
//             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             child: ListTile(
//               title: Text(
//                 '${assets[index]['name']}',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Tahun: ${assets[index]['kategori']}'),
//                 ],
//               ),
//               onTap: () {
//                 // You can navigate to a detailed page or perform other actions here
//                 // For simplicity, this example just prints the asset details
//                 print('Asset Details: ${assets[index]}');
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: fetchassets(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final Map<String, dynamic> jsonResponse =
//               snapshot.data as Map<String, dynamic>;

//           // Assuming 'assets' is the key containing the list of assets in your JSON
//           final List<Map<String, dynamic>> assets =
//               (jsonResponse['assets'] as List<dynamic>?)
//                       ?.cast<Map<String, dynamic>>() ??
//                   [];

//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               title: Text('Asset Management Bosston GYM',
//                   style: TextStyle(color: Colors.white)),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   // Your existing code...

//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                     child: Container(
//                       width: 360,
//                       height: 150,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: const Color.fromARGB(255, 219, 219, 219),
//                           width: 2.0,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Align(
//                             alignment: AlignmentDirectional(-1.00, 0.00),
//                             child: ClipRRect(
//                               child: Image.network(
//                                 assets.isNotEmpty
//                                     ? assets[0]['image']
//                                     : '', // Adjust this to handle the case where assets is empty
//                                 width: 119,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   assets.isNotEmpty
//                                       ? assets[1]['name']
//                                       : '', // Adjust this to handle the case where assets is empty
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(assets.isNotEmpty
//                                     ? assets[1]['kategori']
//                                     : ''), // Adjust this to handle the case where assets is empty
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Align(
//                               alignment: AlignmentDirectional(0.00, 0.00),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Detail(),
//                                     ),
//                                   );
//                                 },
//                                 child: Text('Detail'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // ... Widget Tree ...
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }


//     Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Asset Management'),
//       ),
//       body:ListView.builder(
//             itemCount: assets.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             assets[index].imageUrl,
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               assets[index].name,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(assets[index].category),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//     );
//   }
// }
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Asset>>(
//       future: futureAssets,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Asset> assets = snapshot.data!;
//           return ListView.builder(
//             itemCount: assets.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             assets[index].imageUrl,
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               assets[index].name,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(assets[index].category),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Asset Management Bosston GYM',
//             style: TextStyle(color: Colors.white)),
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
//                 child: Container(
//                   width: 400,
//                   height: 154,
//                   child: Container(
//                       width: double.infinity,
//                       height: 180,
//                       child: CarouselSlider(
//                         items: [
//                           Image.network(
//                             'https://images.unsplash.com/photo-1596357395104-ba989e72b5ec?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                             fit: BoxFit.cover,
//                             width: 360.0,
//                           ),
//                           Image.network(
//                             'https://images.unsplash.com/photo-1596357395217-80de13130e92?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                             fit: BoxFit.cover,
//                             width: 360.0,
//                           ),
//                           Image.network(
//                             'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                             fit: BoxFit.cover,
//                             width: 360.0,
//                           ),
//                         ],
//                         options: CarouselOptions(
//                           height: 200.0,
//                           enlargeCenterPage: true,
//                           autoPlay: true,
//                         ),
//                       )),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Color.fromARGB(255, 219, 219, 219),
//                       width: 0.5,
//                     ),
//                   ),
//                   width: 360,
//                   height: 44,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.search),
//                         onPressed: () {
//                           ();
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height:
//                       150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment
//                               .start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               '${assets[index]['name']}',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                                 ${assets[index]['kategori']}),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Treadmill',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text('Cardio Equipment'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Treadmill',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text('Cardio Equipment'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//                 child: Container(
//                   width: 360,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 219, 219, 219),
//                       width: 2.0,
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Align(
//                         alignment: AlignmentDirectional(-1.00, 0.00),
//                         child: ClipRRect(
//                           child: Image.network(
//                             'https://sunnyhealthfitness.com/cdn/shop/articles/eloisa_treadmill_1024x1024.jpg?v=1692740745',
//                             width: 119,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Treadmill',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text('Cardio Equipment'),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Detail(),
//                                 ),
//                               );
//                             },
//                             child: Text('Detail'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
//                 child: Container(
//                   width: 360,
//                   height: 90,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 12, 8, 12),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Scan()),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               elevation: 4,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text('Scan QR'),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 12),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Scan()),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               elevation: 4,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text('Scan Barcode'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }