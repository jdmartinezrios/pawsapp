import 'package:flutter/material.dart';
// import 'package:pawsapp/views/home.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pawsapp/views/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:transparent_image/transparent_image.dart';
import 'package:pawsapp/my_app/globals.dart' as globals;

class Schudle extends StatefulWidget {
  @override
  SchudlePage createState() => SchudlePage();
}

class SchudlePage extends State<Schudle> {
  final LocalStorage schudle = new LocalStorage('condition');
  double _range = 0;
  String _timeString;
  Timer _timer;
  bool selectedPetOne;
  bool selectedPetTwo;
  AsyncSnapshot<QuerySnapshot> pets;
  Map times = {
    'times': [
      {'number': '1', 'letter': 'S', 'isSelected': false},
      {'number': '2', 'letter': 'S', 'isSelected': false},
      {'number': '3', 'letter': 'M', 'isSelected': false},
      {'number': '4', 'letter': 'T', 'isSelected': false},
      {'number': '5', 'letter': 'W', 'isSelected': false},
      {'number': '6', 'letter': 'T', 'isSelected': false},
      {'number': '7', 'letter': 'F', 'isSelected': false},
      {'number': '8', 'letter': 'S', 'isSelected': false},
      {'number': '9', 'letter': 'S', 'isSelected': false},
      {'number': '10', 'letter': 'M', 'isSelected': false},
      {'number': '11', 'letter': 'T', 'isSelected': false},
      {'number': '12', 'letter': 'W', 'isSelected': false},
      {'number': '13', 'letter': 'T', 'isSelected': false},
      {'number': '14', 'letter': 'F', 'isSelected': false},
      {'number': '15', 'letter': 'S', 'isSelected': false},
      {'number': '16', 'letter': 'S', 'isSelected': false},
      {'number': '17', 'letter': 'M', 'isSelected': false},
      {'number': '18', 'letter': 'T', 'isSelected': false},
      {'number': '19', 'letter': 'W', 'isSelected': false},
      {'number': '20', 'letter': 'T', 'isSelected': false},
      {'number': '21', 'letter': 'F', 'isSelected': false},
      {'number': '22', 'letter': 'S', 'isSelected': false},
      {'number': '23', 'letter': 'S', 'isSelected': false},
      {'number': '24', 'letter': 'M', 'isSelected': false},
      {'number': '25', 'letter': 'T', 'isSelected': false},
      {'number': '26', 'letter': 'W', 'isSelected': false},
      {'number': '27', 'letter': 'T', 'isSelected': false},
      {'number': '28', 'letter': 'F', 'isSelected': false},
      {'number': '29', 'letter': 'S', 'isSelected': false},
      {'number': '30', 'letter': 'S', 'isSelected': false},
    ]
  };

  Map petsList = {};

  @override
  void initState() {
    selectedPetOne = false;
    selectedPetTwo = false;
    // selectedPet = false;
    _timeString = DateTime.now().minute > 9
        ? "${DateTime.now().hour}:${DateTime.now().minute}"
        : "${DateTime.now().hour}:0${DateTime.now().minute}";
    _timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  // void getPetsList() async {
  //   pets = Firestore.instance
  //       .collection('pets')
  //       .orderBy('createAt', descending: true)
  //       .snapshots();
  // }

  void _getCurrentTime() {
    setState(() {
      _timeString = DateTime.now().minute > 9
          ? "${DateTime.now().hour}:${DateTime.now().minute}"
          : "${DateTime.now().hour}:0${DateTime.now().minute}";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (schudle != null && schudle.getItem('condition') == 'yes') {
      return _buildWalkNow();
    } else {
      return _buildSchudle();
    }
  }

  Widget _buildSchudle() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Schedule Walk',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w800,
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
                  // schudle.setItem('condition', 'no');
                  // Navigator.of(context).push(
                  //     (MaterialPageRoute(builder: (context) => MyHomePage())));
                  globals.tabController.index = 0;
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
              height: MediaQuery.of(context).size.height,
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
                      Color.fromRGBO(230, 152, 129, 1),
                      Color.fromRGBO(230, 152, 129, 1),
                    ]),
              ),
              child: Stack(
                // alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40.0),
                    child: Container(
                      width: 240,
                      constraints: BoxConstraints(minWidth: 240, maxWidth: 240),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: _buildPetsList(),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: 'schudle',
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Text('Who is going out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: <Widget>[
                            //     GestureDetector(
                            //       onTap: () {
                            //         selectedPetOne = !selectedPetOne;
                            //       },
                            //       child: Column(
                            //         children: <Widget>[
                            //           Container(
                            //             margin: EdgeInsets.only(top: 10.0),
                            //             height: 80,
                            //             width: 80,
                            //             decoration: BoxDecoration(
                            //               image: DecorationImage(
                            //                   image:
                            //                       AssetImage('assets/pet1.png'),
                            //                   fit: BoxFit.contain),
                            //               borderRadius:
                            //                   BorderRadius.circular(20.0),
                            //               color: selectedPetOne
                            //                   ? Colors.white
                            //                   : Colors.transparent,
                            //             ),
                            //           ),
                            //           Text('Max',
                            //               style: TextStyle(color: Colors.white),
                            //               textAlign: TextAlign.center),
                            //         ],
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         selectedPetTwo = !selectedPetTwo;
                            //       },
                            //       child: Column(
                            //         children: <Widget>[
                            //           Container(
                            //             margin: EdgeInsets.only(top: 10.0),
                            //             height: 80,
                            //             width: 80,
                            //             decoration: BoxDecoration(
                            //               image: DecorationImage(
                            //                   image:
                            //                       AssetImage('assets/pet2.png'),
                            //                   fit: BoxFit.contain),
                            //               borderRadius:
                            //                   BorderRadius.circular(20.0),
                            //               color: selectedPetTwo
                            //                   ? Colors.white
                            //                   : Colors.transparent,
                            //             ),
                            //           ),
                            //           Text('Coco',
                            //               style: TextStyle(color: Colors.white),
                            //               textAlign: TextAlign.center),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 150.0),
                                    child: Text('At What Time',
                                        style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(top: 5.0),
                                    child: Text(_timeString,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 80.0,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 330),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: times['times'].length,
                      padding: EdgeInsets.only(left: 17, right: 17),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  times['times'][index]['isSelected'] =
                                      !times['times'][index]['isSelected'];
                                });
                              },
                              child: ClipOval(
                                child: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  child: Center(
                                    child: Text(times['times'][index]['letter'],
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 193, 175, 1),
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromRGBO(255, 193, 175, 1),
                                        width: 1.5,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                    color: times['times'][index]['isSelected']
                                        ? Colors.white
                                        : Color.fromRGBO(230, 152, 129, 1),
                                  ),
                                ),
                              ),
                            ),
                            Container(margin: EdgeInsets.only(top: 5.0)),
                            Text(times['times'][index]['number'],
                                style: TextStyle(
                                    color: times['times'][index]['isSelected']
                                        ? Colors.white
                                        : Color.fromRGBO(255, 193, 175, 1),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 16,
                        );
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 410.0),
                        child: Text('For How Long',
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
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
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 430.0),
                    child: Center(
                      child: Hero(
                        tag: 'map',
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).push((MaterialPageRoute(
                                builder: (context) =>
                                    Location(buttonColor: 'schudle'))));
                          },
                          child: Icon(
                            Icons.check,
                            color: Color.fromRGBO(230, 152, 129, 1),
                            size: 22.0,
                          ),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                        ),
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
              ),
            ),
          ],
        ),
      );

  Widget _buildWalkNow() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: SizedBox(
                width: double.infinity,
                child: Text('Walk Now',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w800,
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
                  // schudle.setItem('condition', 'no');
                  // Navigator.of(context).push(
                  //     (MaterialPageRoute(builder: (context) => MyHomePage())));
                  globals.tabController.index = 0;
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
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40.0),
                    child: Container(
                      width: 240,
                      constraints: BoxConstraints(minWidth: 240, maxWidth: 240),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: _buildPetsList(),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: 'schudleNow',
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Text('Who is going out',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: <Widget>[
                            //     GestureDetector(
                            //       onTap: () {
                            //         selectedPetOne = !selectedPetOne;
                            //       },
                            //       child: Column(
                            //         children: <Widget>[
                            //           Container(
                            //             margin: EdgeInsets.only(top: 10.0),
                            //             height: 80,
                            //             width: 80,
                            //             decoration: BoxDecoration(
                            //               image: DecorationImage(
                            //                   image:
                            //                       AssetImage('assets/pet1.png'),
                            //                   fit: BoxFit.contain),
                            //               borderRadius:
                            //                   BorderRadius.circular(20.0),
                            //               color: selectedPetOne
                            //                   ? Colors.white
                            //                   : Colors.transparent,
                            //             ),
                            //           ),
                            //           Text('Max',
                            //               style: TextStyle(color: Colors.white),
                            //               textAlign: TextAlign.center),
                            //         ],
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         selectedPetTwo = !selectedPetTwo;
                            //       },
                            //       child: Column(
                            //         children: <Widget>[
                            //           Container(
                            //             margin: EdgeInsets.only(top: 10.0),
                            //             height: 80,
                            //             width: 80,
                            //             decoration: BoxDecoration(
                            //               image: DecorationImage(
                            //                   image:
                            //                       AssetImage('assets/pet2.png'),
                            //                   fit: BoxFit.contain),
                            //               borderRadius:
                            //                   BorderRadius.circular(20.0),
                            //               color: selectedPetTwo
                            //                   ? Colors.white
                            //                   : Colors.transparent,
                            //             ),
                            //           ),
                            //           Text('Coco',
                            //               style: TextStyle(color: Colors.white),
                            //               textAlign: TextAlign.center),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 180.0),
                                  ),
                                  Container(margin: EdgeInsets.only(top: 10.0)),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 20.0),
                                        child: Text('For How Long',
                                            style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20.0),
                                        child: SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            valueIndicatorTextStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    229, 183, 85, 1)),
                                          ),
                                          child: Slider(
                                            activeColor: Colors.white,
                                            inactiveColor: Color.fromRGBO(
                                                255, 230, 177, 1),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Hero(
                            tag: 'map',
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.of(context).push((MaterialPageRoute(
                                    builder: (context) =>
                                        Location(buttonColor: 'walk'))));
                              },
                              child: Icon(
                                Icons.check,
                                color: Color.fromRGBO(229, 183, 85, 1),
                                size: 22.0,
                              ),
                              shape: CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(15.0),
                            ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildPetsList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('pets')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(230, 152, 129, 1),
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        return new PetsListSchedule(document: snapshot.data.documents);
      },
    );
  }

  void dispose() {
    _timer.cancel();
    schudle.setItem('condition', 'no');
    super.dispose();
  }
}

class PetsListSchedule extends StatefulWidget {
  PetsListSchedule({this.document});
  final List document;
  @override
  _PetsListScheduleState createState() => _PetsListScheduleState();
}

class _PetsListScheduleState extends State<PetsListSchedule> {
  final LocalStorage petList = new LocalStorage('condition');
  int indexPet;

  @override
  void initState() {
    // TODO: implement initState
    // indexPet = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (BuildContext ctx, int i) {
        // widget.document[i].data.add({'isSelected': 'false'});
        String name = widget.document[i].data['name'].toString();
        String breed = widget.document[i].data['breed'].toString();
        String years = widget.document[i].data['ages'].toString();
        String image = widget.document[i].data['image'].toString();
        String sexo = widget.document[i].data['sex'].toString();

        return _buildList(name, image, i);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 40,
        );
      },
    );
  }

  Widget _buildList(String name, urlImage, index) {
    return GestureDetector(
      onTap: () {
        // selectedPetOne = !selectedPetOne;
        // widget.document[index]['isSelected'] =
        //     !widget.document[index]['isSelected'];
        setState(() {
          indexPet = index;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            height: 80,
            width: 80,
            // padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  color: indexPet == index
                      ? Colors.white
                      : petList.getItem('condition') == 'yes'
                          ? Color.fromRGBO(229, 183, 85, 1)
                          : Color.fromRGBO(230, 152, 129, 1),
                  width: 5.0),
              // Color.fromRGBO(250, 250, 250, 1)
              // color: Colors.transparent,
              color: Color.fromRGBO(250, 250, 250, 1),
            ),
            child: Container(
              width: 80,
              constraints: BoxConstraints(
                  minWidth: 80, maxWidth: 80, minHeight: 80, maxHeight: 80),
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
              // 'Max',
              name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
