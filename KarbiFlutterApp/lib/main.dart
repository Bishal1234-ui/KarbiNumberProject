import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassification/about.dart';
import 'package:imageclassification/classifier.dart';
import 'package:imageclassification/classifier_float.dart';
import 'package:imageclassification/classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Classification',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: "Kabri Translator",),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Classifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;


  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3),
    // ()=> Navigator.pushReplacement(context, 
    //                                   MaterialPageRoute(builder: (context) => SecondScreen(),))
    // );
    _classifier = ClassifierFloat();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
    });
  }

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
                     builder: (BuildContext context) => MyHomePage(
                    
                     ),
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
                     builder: (BuildContext context) =>  About(
                     ),
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
      body: LayoutBuilder(builder:(context, constraints) {
        return Column(
          children: [
            SingleChildScrollView(
              child: Container(
                // color: Color.fromARGB(255, 247, 228, 173),
                height: constraints.maxHeight * 0.93,
                width: constraints.maxWidth,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bgm.png"),
                    opacity: 120
                  )
                ),
                child: Column(
                  children: <Widget>[
                     SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: _image == null
              ? Column(
                children: [
                   Text(' KARBI TRANS ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 80, 79, 79),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2
                          ),             
                        ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: constraints.maxWidth * 0.6,
                    child: Image(
                      image: AssetImage("assets/imgicon.png"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.warning,
                          color: Color.fromARGB(255, 80, 79, 79),
                        ),
                        Text(' No Image Selected! ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 80, 79, 79),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2
                          ),             
                        ),
                        Icon(
                          Icons.warning,
                          color: Color.fromARGB(255, 80, 79, 79),
                        )
                      ],
                    ),
                  ),
                ],
              )
              : Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 2),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: _imageWidget,
                ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Text(
                      category != null?
                      "THE GIVEN NUMBER IS :": '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      category != null ? category!.label : '',
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                        ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      category != null
              ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
              : '',
                      style: TextStyle(fontSize: 16, letterSpacing: 2),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              
              height: constraints.maxHeight * 0.07,
              decoration: BoxDecoration(
              color: Color.fromARGB(255, 86, 184, 184),
              border: Border.all(
                color: Color.fromARGB(255, 239, 241, 241)
              ),
              borderRadius: BorderRadius.circular(20)
            ),
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SELECT AN IMAGE OF KARBI NUMBER", style: TextStyle(
                    color: Colors.white,
                    fontSize: 13
                  )),
                  Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                  )
                ],
              )),
            )
          ],
        );
      },),
      

      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
