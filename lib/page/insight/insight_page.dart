import 'package:flutter/material.dart';

class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insight'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          _buildCard(
            context,
            'assets/images/boy_profile1.jpeg',
            'James Baker',
            4,
            'Today, 08:30AM',
            'A simple white t-shirt paired with shorts and sneakers. You can add a baseball cap and sunglasses to complete the look. This is a classic and comfortable outfit for a casual day out.',
          ),
          _buildCard(
            context,
            'assets/images/girl_profile1.jpg',
            'Jessica Maria',
            5,
            'Today, 07:22AM',
            'A flowy sundress in a light fabric like cotton or linen, paired with sandals and a straw tote bag. You can accessorize with sunglasses and a floppy hat to protect yourself from the sun.',
          ),
          _buildCard(
            context,
            'assets/images/boy_profile2.jpeg',
            'Noah Lee',
            3,
            'Today, 06:50AM',
            'A short-sleeved button-up shirt paired with chinos or khakis and loafers or boat shoes. You can add a leather belt and a lightweight blazer for a more polished look. This is a great outfit for a semi-casual event or date.',
          ),
          _buildCard(
            context,
            'assets/images/boy_profile3.jpeg',
            'Bob Johnson',
            5,
            'Today, 06:30AM',
            'A polo shirt paired with tailored shorts and sandals or boat shoes. You can add a watch and a canvas tote bag to complete the look. This outfit is perfect for a preppy and casual vibe.',
          ),
          _buildCard(
            context,
            'assets/images/girl_profile2.jpeg',
            'Sophia Williams',
            4,
            'Today, 05:40AM',
            'High-waisted shorts with a crop top or a lightweight blouse, paired with sneakers or espadrilles. You can add a denim jacket or a cardigan for layering. This look is perfect for a casual day out.',
          ),
          _buildCard(
            context,
            'assets/images/girl_profile3.jpeg',
            'Ava Thompson',
            5,
            'Yesterday, 22:30PM',
            'A maxi skirt paired with a tank top or a halter top, sandals, and a crossbody bag. You can accessorize with a long necklace or statement earrings. This look is perfect for a bohemian or beachy vibe.',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String username, int stars, String time, String content) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text(
                        stars.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
