import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utswakhid1/detail.dart';

class Laporan extends StatefulWidget {
  const Laporan({super.key});
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  String typeDamage = 'Rusak Sebagian';
  String everDamaged = 'Ya';
  String resultText = '';

  int calculateRepairDays() {
    if (everDamaged == 'Ya') {
      if (typeDamage == 'Rusak Sebagian') {
        return 4;
      } else if (typeDamage == 'Rusak Sedang') {
        return 8;
      } else if (typeDamage == 'Rusak Parah') {
        return 14;
      }
    } else {
      if (typeDamage == 'Rusak Sebagian') {
        return 2;
      } else if (typeDamage == 'Rusak Sedang') {
        return 4;
      } else if (typeDamage == 'Rusak Parah') {
        return 7;
      }
    }
    return 0;
  }

  void calculate() {
    final result = '${calculateRepairDays()} Hari';
    setState(() {
      resultText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
        final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Failed to retrieve details'),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Laporan Kerusakan', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  args['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Berikanlah laporan kerusakan',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                'Type Kerusakan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButton<String>(
                  value: typeDamage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        typeDamage = newValue;
                      });
                    }
                  },
                  items: <String>[
                    'Rusak Sebagian',
                    'Rusak Sedang',
                    'Rusak Parah'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: 340,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Text(
                'Uraian Kerusakan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(),
              ),
              Text(
                'Pernah Rusak Sebelumnya?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButton<String>(
                  value: everDamaged,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        everDamaged = newValue;
                      });
                    }
                  },
                  items: <String>['Ya', 'Tidak']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: 340,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Type Kerusakan: $typeDamage',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Pernah Rusak Sebelumnya: $everDamaged',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text('Estimasi Perbaikan'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      resultText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: calculate,
                    child: Text('Hitung'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Laporkan'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
