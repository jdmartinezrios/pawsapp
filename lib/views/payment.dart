import 'package:flutter/material.dart';
import 'package:pawsapp/fonts/my_flutter_app_icons.dart';
// import 'package:pawsapp/views/home.dart';
import 'package:pawsapp/my_app/globals.dart' as globals;

class Payment extends StatefulWidget {
  @override
  PaymentPage createState() => PaymentPage();
}

class PaymentPage extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 152, 129, 1),
      body: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0),
          child: SizedBox(
            width: double.infinity,
            child: Text('Payment',
                style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center),
          ),
        ),
        Positioned(
          top: 40.0,
          left: 20.0,
          child: Icon(
            MyFlutterApp.th_large_outline,
            size: 20,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 25.0,
          right: 10.0,
          child: GestureDetector(
            onTap: () {
              print('press button');
              // Navigator.of(context).push(
              //     (MaterialPageRoute(builder: (context) => MyHomePage())));
              globals.tabController.index = 0;
            },
            child: ClipOval(
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Center(
                    child: Icon(Icons.add, color: Colors.white, size: 40),
                  )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 106, left: 0.0, right: 0.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //  - 80.0,
          padding: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0)),
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  size: 100,
                  color: Color.fromRGBO(230, 152, 129, 1),
                ),
                Text(
                  'Comming Soon!...',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: Color.fromRGBO(230, 152, 129, 1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
