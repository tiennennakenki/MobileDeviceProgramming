import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFireBaseConnect extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const MyFireBaseConnect({Key? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder}) : super(key: key);

  @override
  State<MyFireBaseConnect> createState() => _MyFireBaseConnectState();
}

class _MyFireBaseConnectState extends State<MyFireBaseConnect> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi) {
      return Container(
        color: Colors.white,
        child: Center(
            child: Text(widget.errorMessage!,
              style: TextStyle(fontSize: 16),
              textDirection: TextDirection.ltr,
            )

        ),
      );
    }
    if(!ketNoi) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(widget.connectingMessage!,
                style: TextStyle(fontSize: 16),
                textDirection: TextDirection.ltr,
              )
            ],
          ),
        ),
      );
    }
    else {
      return widget.builder!(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase(){
    Firebase.initializeApp()
        .then((value) { //try
      setState(() {
        ketNoi = true;
      });
    }).catchError((error) {//catch
      print(error);
      setState(() {
        loi = true;
      });
    }).whenComplete(() => print("Kết thúc việc khởi tạo Firebase"));//Finally
  }
}