import 'function.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;
  String output = 'Null';
  late File _imageFile;
  final myController = TextEditingController();

  Future getImage(var source) async {
    XFile? imageFile;
    if (source == 'camera') {
      output = 'null';
      imageFile = await ImagePicker()
          .pickImage(source: ImageSource.camera); // to take from camera,
    } else if (source == 'gallery') {
      output = 'null';
      imageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery); // to take from gallery,
    } else {
      // don't know what happens here
    }

    setState(() {
      if (imageFile != null) {
        _imageFile = File(imageFile.path);
      }
      //_imageFile = File(imageFile!.path);
    });
  }

  @override
  void dispose() {
    // clean up controller when widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask ChatGPT')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your query',
              ),
            ),
            TextButton(
                onPressed: () async {
                  data = await uploadImage(myController.text);
                  if (kDebugMode) {
                    print(myController.text);
                  }
                  // print(data);
                  var decoded = jsonDecode(data);
                  setState(() {
                    output = decoded['output'];
                    if (kDebugMode) {
                      print(output);
                    } // only for viewing results on system.
                  });
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.blueAccent),
                  )),
                ),
                child: const Text(
                  'Upload',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 40),
                )),
            Text(
              'Answer: $output',
              style: const TextStyle(fontSize: 40, color: Colors.green),
            )
          ]),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
