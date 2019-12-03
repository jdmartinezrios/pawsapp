import 'package:flutter/material.dart';
import 'package:pawsapp/fonts/my_flutter_app_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pawsapp/my_app/globals.dart' as globals;

class Welcome extends StatefulWidget {
  @override
  WelcomePage createState() => WelcomePage();
}

class WelcomePage extends State<Welcome> with TickerProviderStateMixin {
  final LocalStorage welcome = new LocalStorage('condition');
  double _scale;
  AnimationController _controller;
  double _scale2;
  AnimationController _controller2;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    _scale2 = 1 - _controller2.value;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25.0),
            child: SizedBox(
              width: double.infinity,
              child: Text('Welcome',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      color: Color.fromRGBO(82, 82, 82, 1),
                      fontSize: 40.0,
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
              color: Colors.black,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                // margin: EdgeInsets.only(top: 40.0),
                child: Hero(
                  tag: 'schudle',
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment(0, 0),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => goToSchudle(),
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          child: Transform.scale(
                            scale: _scale,
                            child: Container(
                              width: 300,
                              child: Image(
                                image: AssetImage('assets/Schedule_Walk.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // {
                          //   print('object walk');
                          //   welcome.setItem('condition', 'no');
                          //   globals.tabController.index = 2;
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                // margin: EdgeInsets.only(top: 40.0),
                child: Hero(
                  tag: 'schudleNow',
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment(0, 0),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => goToWalkNow(),
                          onTapDown: _onTapDown2,
                          onTapUp: _onTapUp2,
                          // {
                          //   print('object walk');
                          //   welcome.setItem('condition', 'no');
                          //   globals.tabController.index = 2;
                          // },
                          child: Transform.scale(
                            scale: _scale2,
                            child: Container(
                              width: 300,
                              child: Image(
                                image: AssetImage('assets/Walk_Now.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(10.0),
              //   child: Hero(
              //     tag: 'walkNow',
              //     child: SizedBox(
              //       width: double.infinity,
              //       child: Stack(
              //         alignment: Alignment(0, 0),
              //         children: <Widget>[
              //           GestureDetector(
              //             onTap: () => goToWalkNow(),
              //             // {
              //             //   print('object walk');
              //             //   welcome.setItem('condition', 'yes');
              //             //   globals.tabController.index = 2;
              //             // },
              //             child: Container(
              //               width: 300,
              //               child: Image(
              //                 image: AssetImage('assets/Walk_Now.png'),
              //                 fit: BoxFit.contain,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void goToWalkNow() {
    _controller2.forward();
    welcome.setItem('condition', 'yes');
    Future.delayed(const Duration(milliseconds: 200), () {
      globals.tabController.index = 2;
    });
  }

  void goToSchudle() {
    _controller.forward();
    welcome.setItem('condition', 'no');
    Future.delayed(const Duration(milliseconds: 200), () {
      globals.tabController.index = 2;
    });
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapDown2(TapDownDetails details) {
    _controller2.forward();
  }

  void _onTapUp2(TapUpDetails details) {
    _controller2.reverse();
  }
}
