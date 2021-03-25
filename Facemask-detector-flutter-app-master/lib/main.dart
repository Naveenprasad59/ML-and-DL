import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
             centerTitle: true,
             title: Text('mask detector'),
             backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: MyImagePicker(),
                  ),
                ),
              );
            }
          }
          
class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}
class MyImagePickerState extends State {

  File imageURI;
  String result;
  String path;

  Future getImageFromCamera() async {

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }
  Future getImageFromGallery() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    imageURI = image;
    path = image.path;
  });
}
Future classifyImage() async {
  await Tflite.loadModel(model: "assets/converted_model.tflite",labels: "assets/labels0.txt");
  var output = await Tflite.runModelOnImage(path: path);
  setState(() {
    result = output.toString();
  });
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
        imageURI == null
          ? Text('No image selected.')
          : Image.file(imageURI, width: 300, height: 300, fit: BoxFit.cover),

        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: RaisedButton(
            onPressed: () => getImageFromCamera(),
            child: Text('Click Here To Select Image From Camera'),
            textColor: Colors.white,
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),

        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: RaisedButton(
            onPressed: () => getImageFromGallery(),
            child: Text('Click Here To Select Image From Gallery'),
            textColor: Colors.white,
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),

        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: RaisedButton(
            onPressed: () => classifyImage(),
            child: Text('Classify Image'),
            textColor: Colors.white,
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),     

        result == null
          ? Text('Result')
          : Text(result,style: TextStyle(fontWeight: FontWeight.bold),),    
    ]))
    );
  }
}

            
         


