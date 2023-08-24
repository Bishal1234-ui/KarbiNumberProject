import 'package:flutter/material.dart';
import 'main.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer : Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: [
             const UserAccountsDrawerHeader(
               currentAccountPicture: CircleAvatar(
                 backgroundImage: AssetImage("assets/hm.png")
               ),
               accountEmail: Text('A Karbi Number Translator'),
               accountName: Text(
                 'KARBI TRANS',
                 style: TextStyle(fontSize: 22.0),
               ),
               decoration: BoxDecoration(
                 color: Colors.teal,
               ),
             ),
             ListTile(
               
               leading: const Icon(Icons.home),
               title: const Text(
                 'Home',
                 style: TextStyle(fontSize: 22.0),
               ),
               onTap: () {
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute<void>(
                     builder: (BuildContext context) => MyHomePage(),
                   ),
                 );
               },
             ),
             ListTile(
               leading: const Icon(Icons.info),
               title: const Text(
                 'About',
                 style: TextStyle(fontSize: 22.0),
               ),
               onTap: () {
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute<void>(
                     builder: (BuildContext context) =>  About(),
                   ),
                 );
               },
             ),
             
           ],
         ),
       ),
      
      appBar: AppBar(
        shape: RoundedRectangleBorder(

                      borderRadius:  BorderRadius.only(

                                                bottomRight: Radius.circular(20),

                                                bottomLeft: Radius.circular(20))

                                                     ),
        centerTitle: true,
        title: Text('KARBI  NUMBER  TRANSLATOR',
        textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17)),
            
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/hm.png'),
                  radius: 60,
                ),
              ),
              Divider(
                height: 60,
                color: Colors.grey[700],
              ),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Karbi Trans',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'FUNCTION',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Translates Karbi Numbers to English',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'DESCRIPTION',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'The app is made with Convolutional Neural Network using Tensorflow library that translates the image of any karbi number to its English counterpart with an accuracy upto 90%.',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'TECHNOLOGIES USED',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Tensorflow Lite ',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2. Flutter ',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '3. Google Teachable Machine ',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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