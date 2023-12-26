import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utswakhid1/scanqr.dart';
import 'package:utswakhid1/main.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/home',
              );
            },
          ),
          title: Text('Scan', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://down-id.img.susercontent.com/file/id-11134103-7r98o-lklt8f4qe9u183',
                      width: double.infinity,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Terscan');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 54),
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Scan'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
