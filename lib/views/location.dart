import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawsapp/fonts/my_flutter_app_icons.dart';

class Location extends StatefulWidget {
  final buttonColor;

  Location({this.buttonColor});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> with TickerProviderStateMixin {
  GoogleMapController mapController;
  bool preload;
  AnimationController _controller;
  AnimationController _controllerFade;
  Tween<double> _tween = Tween(begin: 0.50, end: 1);
  Animation _animation;

  @override
  void initState() {
    preload = false;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
    _controllerFade = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controllerFade);
    super.initState();
  }

  final LatLng _center = const LatLng(3.679505, -76.309845);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Hero(
            tag: 'map',
            child: !preload
                ? Stack(
                    children: <Widget>[
                      GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11.0,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            print('press button');
                            Navigator.of(context).pop();
                          },
                          child: ClipOval(
                            child: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    // MyFlutterApp.th_large_outline,
                                    size: 20,
                                    color: (widget.buttonColor == 'walk')
                                        ? Color.fromRGBO(229, 183, 85, 1)
                                        : Color.fromRGBO(230, 152, 129, 1),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ButtonTheme(
                              minWidth: 150.0,
                              child: RaisedButton(
                                onPressed: () {
                                  _finishedProccess();
                                },
                                color: (widget.buttonColor == 'walk')
                                    ? Color.fromRGBO(229, 183, 85, 1)
                                    : Color.fromRGBO(230, 152, 129, 1),
                                child: Text(
                                  "I'm here",
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : FadeTransition(
                    opacity: _animation,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: (widget.buttonColor == 'walk')
                          ? Color.fromRGBO(229, 183, 85, 1)
                          : Color.fromRGBO(230, 152, 129, 1),
                      child: Center(
                        child: ScaleTransition(
                          scale: _tween.animate(CurvedAnimation(
                              parent: _controller, curve: Curves.elasticOut)),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/preload.png'),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _finishedProccess() {
    setState(() => preload = true);
    _controllerFade.forward();
    Future.delayed(const Duration(milliseconds: 3000), () {
      _controllerFade.reverse();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() => preload = false);
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerFade.dispose();
    super.dispose();
  }
}
