import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var result="Scan Your Barcode";
  @override
  void initState(){
    super.initState();
  }
  Future _scanQR() async{
    try{
      var qrResult = await BarcodeScanner.scan();
      print(qrResult);
      setState((){
          this.result = qrResult.rawContent;
      });
    }on PlatformException catch(ex){
      if(ex.code == BarcodeScanner.cameraAccessDenied){
        setState((){
          result ="Camera Permission Was Denied";
        });
      }else{
        setState((){
          result ="Something Went Wrong $ex";
        });
      }
    }on  FormatException{
      setState((){
        result ="You Pressed The Back Button Before Scanning";
      });
    }catch(ex){
      setState((){
        result ="$ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("QR Scanner"),
        ),
        body: Center(
          child: Text(result,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _scanQR,
          icon: Icon(Icons.camera_alt),
          label: Text("Scanner")
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
