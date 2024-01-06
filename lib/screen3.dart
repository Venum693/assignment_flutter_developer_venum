import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Screen3 extends StatefulWidget {
  final String imagePath;
  final int number;
   const Screen3({super.key,  required this.imagePath, required this.number});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {

  int _currentImageIndex = 0;
  final List<String> _imagePaths = [

    'assets/images/image1.png',
    'assets/images/image4.png',
    'assets/images/image3.png',
    // ... add more image paths
  ];

  @override
  void initState() {
    super.initState();
    // Add the imagePath to the list
    _imagePaths.add(widget.imagePath);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Description",
          style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                Container(
                  height: 250,
                  color: Colors.grey.shade400,
                  child: Column(
                    children: [
                      SizedBox(
                        height:200,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: PageController(initialPage: 0),
                              onPageChanged: (index) => setState(() => _currentImageIndex = index),
                              itemCount: _imagePaths.length,
                              itemBuilder: (context, index) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    _imagePaths[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _imagePaths
                                      .map((_) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: _currentImageIndex == _imagePaths.indexOf(_)
                                            ? Colors.white
                                            : Colors.grey,
                                        shape: BoxShape.circle),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.file_download_outlined)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.bookmark_border)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.heart_broken_rounded)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.crop_free)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.star_border_purple500_sharp)
                          ),
                          IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.share)
                          ),

                        ],
                      )
                    ],
                  ),
                ),

                Image.asset(
                  widget.imagePath, // Access imagePath from the widget
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  'Number: ${widget.number}', // Access number from the widget
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
