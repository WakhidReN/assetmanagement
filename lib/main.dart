import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:utswakhid1/home.dart';
import 'package:utswakhid1/laporan.dart';
import 'package:utswakhid1/scanqr.dart';
import 'package:utswakhid1/detail.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asset Management Bosston Gym',
      initialRoute: '/home',
      routes: {
        "/home": (context) => const Home(),
        "/scan": (context) => const Scan(),
        "/detail": (context) => const Detail(),
        "/laporan": (context) => const Laporan(),
      },
    );
  }
}