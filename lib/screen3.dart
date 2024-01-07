import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';

class Screen3 extends StatefulWidget {
  final String imagePath;
  final int number;
   const Screen3({super.key,  required this.imagePath, required this.number});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {

  int _currentIndex = 0;// for bottom navigation bar

  double starRating = 3.5;

  PageController _pageController = PageController(initialPage: 0); //page controller to start
  int _currentImageIndex = 0;
  final List<String> _imagePaths = [

    'assets/images/image1.png',
    'assets/images/image4.png',
    'assets/images/image3.png',
    // list of asset image paths
  ];

  late String _imageShare;

  @override
  void initState() {
    super.initState();
    // Add the imagePath to the list. this is image is from previous page
    _imagePaths.add(widget.imagePath);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //moves back
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Description",
          style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    )
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height:200,
                        child: Stack(
                          children: [

                            // sliding view of images

                            PageView.builder(
                              controller: _pageController,
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

                            // dotted indicatos of image display
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
                                            : Colors.grey,  //selected and unselected colors of dots
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.file_download_outlined)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.bookmark_border)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.favorite)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.crop_free)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.star_border_purple500_sharp)
                          ),
                          IconButton(
                              onPressed: () async {
                                await shareCurrentImage(); // calls the method that executes sharing of image
                              },
                              icon: const Icon(Icons.share)
                          ),


                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                Row(
                  children: [
                    const Icon(Icons.bookmark_border,color: Colors.blue,),
                    const Text('1034',),
                    const SizedBox(width: 10),
                    const Icon(Icons.favorite_border_outlined,color: Colors.blue,),
                    const Text('1034',),

                    const SizedBox(width: 10,),

                    // star rating
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AnimatedRatingStars(
                          initialRating: 3.5,
                          minRating: 0.0,
                          maxRating: 5.0,
                          filledColor: Colors.tealAccent,
                          emptyColor: Colors.white,
                          filledIcon: Icons.star,
                          halfFilledIcon: Icons.star_half,
                          emptyIcon: Icons.star_border,
                          onChanged: (double rating) {
                            // Handle the rating change here
                             setState(() {
                               starRating = rating;
                             });

                          },
                          displayRatingValue: true,
                          interactiveTooltips: true,
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                          starSize: 12.0,
                          animationDuration: Duration(milliseconds: 300),
                          animationCurve: Curves.easeInOut,
                          readOnly: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text('$starRating',style: TextStyle(
                        color: Colors.lightBlue.shade900,fontSize: 18,fontWeight: FontWeight.w500
                    ),)
                  ],
                ),

                const SizedBox(height: 20,),

                Text('Actor Name',style: TextStyle(
                  color: Colors.lightBlue.shade900,fontSize: 18,fontWeight: FontWeight.w600
                ),),

                const Text('Indian Actress',style: TextStyle(
                  color: Colors.grey,
                    fontSize: 16,
                ),),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Icon(Icons.access_time_filled,color: Colors.grey,),
                    Text(' Duration 20 Mins',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet_sharp,color: Colors.grey,),
                    Text(' Total Average Fees ₹9,999',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                  ],
                ),
                const SizedBox(height: 10,),
                Text('About',style: TextStyle(
                    color: Colors.lightBlue.shade900,fontSize: 18,fontWeight: FontWeight.w600
                ),),
                const SizedBox(height: 10,),
                const Text('From cardiovascular health to fitness, flexibility, balance, stress relief, better sleep, increased cognitive performance, and more, you can reap all of these benefits in just one session out on the waves. So, you may find yourself wondering what are the benefits of going on a surf camp.',
                  style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){},
                      child: Text('See More',style: TextStyle(
                          color: Colors.lightBlue.shade900,fontSize: 16,fontWeight: FontWeight.w400
                      ),)),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'Prolet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            label: 'Meetup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste_search_outlined),
            label: 'Explpore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }


  Future<void> shareCurrentImage() async {
    try {
      String currentImagePath = _imagePaths[_currentImageIndex]; // copy the current image being shown to be shared

      // Load the image ByteData
      ByteData byteData = await rootBundle.load(currentImagePath);
      List<int> bytes = byteData.buffer.asUint8List();

      final temp = await getTemporaryDirectory();
      final path = "${temp.path}/image.jpg";
      File(path).writeAsBytesSync(bytes);

      // Share the image and wait for completion
      await Share.shareXFiles([XFile(path)], text: 'Great Pic : $_currentImageIndex');

      //  clean up the temporary file after sharing
      File(path).delete();
    } catch (e) {
      print('Error: $e');
    }
  }

}
