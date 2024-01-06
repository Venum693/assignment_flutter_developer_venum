import 'package:assignment_flutter_developer_venum/screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';


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
    'assets/images/image5.png',
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
      body: SingleChildScrollView(
        child: Padding(
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
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  children: [
                    _buildCard( 'Author',1028),
                    _buildCard('Reader',7220),
                    _buildCard('Editor',10080),
                    // Add more cards as needed
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Top Trending Meetups",style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,fontWeight: FontWeight.w600)),
              ),

              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  children: [
                    _buildCardMeetups(1),
                    _buildCardMeetups(2),
                    _buildCardMeetups(3),
                    _buildCardMeetups(4),
                    _buildCardMeetups(5)
                    // Add more cards as needed
                  ],
                ),
              ),
            ],
          ),
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

  Widget _buildCard( String title, int numbers) {
    return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Colors.grey)
    ),

    child: Container(
      width: 250, // Adjust card width as desired
      //padding: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 21,
                    backgroundColor: Colors.blueGrey,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.brush_sharp),
                      ),
                    ),
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 18,fontWeight: FontWeight.w500)),
                    Text("$numbers meetups",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            Divider(color: Colors.grey,thickness: 1),
            SignedSpacingRow(
              spacing: -16.0,
              stackingOrder: StackingOrder.firstOnTop,
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/image4.png'),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/image7.png'),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/image2.png'),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/image6.png'),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/image8.png'),
                )
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (){},
                child: Text("See more",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              )
            ),

          ],
        ),
      )
    ),
        );
  }

  Widget _buildCardMeetups(int i) {
    return GestureDetector(
      onTap:  () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Screen3(imagePath: 'assets/images/image6.png', number: i),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey),
        ),
        child: Container(
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Apply rounded corners
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/image6.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                    ),
                    child: Center(
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
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
