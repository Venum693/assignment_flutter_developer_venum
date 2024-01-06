import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {

  final _pageController = PageController();
  int _currentPage = 0;

  final _assetImages = [
    'assets/images/image1.png', // Replace with your asset paths
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];


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
        title: Text("Individual Meetup",
          style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,size: 35),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic,size: 35),
                  onPressed: () { }, // Implement voice search functionality
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              height: 200,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _assetImages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),

                          child: Image.asset(
                            _assetImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(" Popular Meetups \n in India",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),


            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _assetImages.length,
                    (index) => _buildDot(index == _currentPage),
              ),
            ),

            SizedBox(height: 10,),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("Trending Popular people",style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,fontWeight: FontWeight.w600)),
            ),
            ListView(
              scrollDirection: Axis.horizontal, // Scroll horizontally
              children: [
                _buildCard(Colors.blue, 'Card 1'),
                _buildCard(Colors.green, 'Card 2'),
                _buildCard(Colors.purple, 'Card 3'),
                // Add more cards as needed
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCard(Color color, String title) {
    return Card(
      color: color,
      child: Container(
        width: 200, // Adjust card width as desired
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
