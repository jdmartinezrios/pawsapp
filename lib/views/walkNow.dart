import 'package:flutter/material.dart';
import 'package:pawsapp/views/home.dart';

class WalkNow extends StatefulWidget {
  @override
  _WalkNowState createState() => _WalkNowState();
}

class _WalkNowState extends State<WalkNow> {
  double _range = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0),
          child: SizedBox(
            width: double.infinity,
            child: Text('Schudle Walk',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Color.fromRGBO(82, 82, 82, 1)),
                textAlign: TextAlign.center),
          ),
        ),
        Positioned(
          top: 25.0,
          left: 10.0,
          child: GestureDetector(
            onTap: () {
              print('press button');
              Navigator.of(context).push(
                  (MaterialPageRoute(builder: (context) => MyHomePage())));
            },
            child: ClipOval(
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Center(
                    child: Icon(Icons.arrow_back,
                        color: Color.fromRGBO(82, 82, 82, 1)),
                  )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100.0, left: 0.0, right: 0.0),
          height: MediaQuery.of(context).size.height - 80.0,
          padding: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0)),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                stops: null,
                colors: [
                  Color.fromRGBO(229, 183, 85, 1),
                  Color.fromRGBO(229, 183, 85, 1),
                ]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text('Who is going out',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/pet1.png'),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Text('Max',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/pet2.png'),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Text('Coco',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text('At What Time',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text('13:30',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 80.0,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center),
                    ),
                    Container(margin: EdgeInsets.only(top: 10.0)),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text('For How Long',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorTextStyle: TextStyle(
                                  color: Color.fromRGBO(230, 152, 129, 1)),
                            ),
                            child: Slider(
                              activeColor: Colors.white,
                              inactiveColor: Color.fromRGBO(255, 193, 175, 1),
                              value: _range,
                              onChanged: (newRange) {
                                setState(() => _range = newRange);
                              },
                              min: 0,
                              max: 90,
                              divisions: 18,
                              label: '${_range.toInt()} min',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: RawMaterialButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.check,
                                color: Colors.teal[900],
                                size: 22.0,
                              ),
                              shape: CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(15.0),
                            ),
                            // FlatButton(
                            //   onPressed: () {},
                            //   color: Colors.white,
                            //   child: Icon(Icons.check,
                            //       color: Colors.teal[900]),
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius:
                            //           BorderRadius.circular(30.0)),
                            // ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
