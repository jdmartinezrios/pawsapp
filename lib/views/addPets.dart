import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPets extends StatefulWidget {
  // final heroTag;

  // AddPets({this.heroTag});

  @override
  _AddPetsState createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> with TickerProviderStateMixin {
  File _image;
  bool statusSelectMale, statusSelectFemale, preload;
  double _ages = 0;
  String _url, _name, _breed, _sex;
  final _formKey = GlobalKey<FormState>();

  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.50, end: 1);
  AnimationController _controllerFade;
  Animation _animation;

  @override
  void initState() {
    preload = false;
    statusSelectMale = false;
    statusSelectFemale = false;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
    _controllerFade = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controllerFade);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !preload
          ? Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(230, 152, 129, 1),
                ),
                Positioned(
                  bottom: 25,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: RawMaterialButton(
                        onPressed: () {
                          _saveImageinDatabase();
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
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text('Add Pets',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color.fromRGBO(230, 152, 129, 1)),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Positioned(
                        top: 25.0,
                        left: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            print('press button');
                            Navigator.of(context).pop();
                          },
                          child: ClipOval(
                            child: Container(
                                height: 50.0,
                                width: 50.0,
                                child: Center(
                                  child: Icon(Icons.arrow_back,
                                      color: Color.fromRGBO(230, 152, 129, 1)),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: EdgeInsets.only(top: 80),
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Hero(
                                  tag: 'add',
                                  child: _image != null
                                      ? GestureDetector(
                                          onTap: () {
                                            _choosePicture();
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // image: DecorationImage(
                                              //   image: AssetImage(_image.path),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.file(
                                                _image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _choosePicture();
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    230, 152, 129, 1),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(Icons.add,
                                                  color: Color.fromRGBO(
                                                      230, 152, 129, 1),
                                                  size: 40.0),
                                            ),
                                          ),
                                        ),
                                ),
                                Expanded(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 12),
                                        child: Form(
                                          key: _formKey,
                                          child: Wrap(
                                            children: <Widget>[
                                              Container(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value.isEmpty)
                                                      return 'This field is required';
                                                    return null;
                                                  },
                                                  onSaved: (value) =>
                                                      _name = value,
                                                  cursorColor: Color.fromRGBO(
                                                      230, 152, 129, 1),
                                                  decoration: InputDecoration(
                                                    labelText: 'Name',
                                                    fillColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                    hoverColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                    focusColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 20.0,
                                                    // left: 12,
                                                    bottom: 30.0),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value.isEmpty)
                                                      return 'This field is required';
                                                    return null;
                                                  },
                                                  onSaved: (value) =>
                                                      _breed = value,
                                                  cursorColor: Color.fromRGBO(
                                                      230, 152, 129, 1),
                                                  decoration: InputDecoration(
                                                    labelText: 'Breed',
                                                    fillColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                    hoverColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                    focusColor: Color.fromRGBO(
                                                        230, 152, 129, 1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 300.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                'Age',
                                style: TextStyle(
                                    color: Color.fromRGBO(230, 152, 129, 1)),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  valueIndicatorTextStyle:
                                      TextStyle(color: Colors.white),
                                ),
                                child: Slider(
                                  activeColor: Color.fromRGBO(230, 152, 129, 1),
                                  inactiveColor:
                                      Color.fromRGBO(255, 193, 175, 1),
                                  value: _ages,
                                  onChanged: (newRange) {
                                    setState(() => _ages = newRange);
                                  },
                                  min: 0,
                                  max: 10,
                                  divisions: 10,
                                  label: '${_ages.toInt()} Years',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 18.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      statusSelectMale = !statusSelectMale;
                                      statusSelectFemale = false;
                                      // if (statusSelectMale) {
                                      _sex = 'M';
                                      // } else {
                                      // _sex = '';
                                      // }
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.only(right: 20.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: !statusSelectMale
                                          ? AssetImage(
                                              'assets/Male_Unselected.png')
                                          : AssetImage(
                                              'assets/Male_Selected.png'),
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      statusSelectFemale = !statusSelectFemale;
                                      statusSelectMale = false;
                                      // if (statusSelectMale) {
                                      _sex = 'F';
                                      // } else {
                                      //   _sex = '';
                                      // }
                                    });
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.only(left: 20.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: !statusSelectFemale
                                          ? AssetImage(
                                              'assets/Female_Unselected.png')
                                          : AssetImage(
                                              'assets/Female_Selected.png'),
                                      fit: BoxFit.cover,
                                    )),
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
            )
          : Stack(
              children: <Widget>[
                FadeTransition(
                  opacity: _animation,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromRGBO(230, 152, 129, 1),
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
                        // Image(
                        //   image: AssetImage('assets/preload.png'),
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _savePetInDatabase(String url) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('pets');
      await reference.add({
        'name': _name,
        'breed': _breed,
        'sex': _sex,
        'ages': _ages.toInt(),
        'createAt': new DateTime.now(),
        'image': url
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        _controllerFade.reverse();
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() => preload = false);
          _dismiss();
        });
      });
    });
  }

  void _dismiss() {
    setState(() {
      _ages = 0;
      _image = null;
      statusSelectMale = false;
      statusSelectFemale = false;
      _formKey.currentState.reset();
    });
  }

  bool _validateForm() {
    var _form = _formKey.currentState;

    if ((_form.validate() && _image != null) && (_sex != '' || _sex != null)) {
      print('save data');
      _form.save();
      return true;
    } else {
      return false;
    }
  }

  void _saveImageinDatabase() async {
    if (_validateForm()) {
      // preload = true;
      setState(() => preload = true);
      _controllerFade.forward();
      final StorageReference petImageRef =
          FirebaseStorage.instance.ref().child('Pets Images');

      var _timeCreation = new DateTime.now();
      final StorageUploadTask uploadTask =
          petImageRef.child(_timeCreation.toString() + '.jpg').putFile(_image);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      _url = imageUrl.toString();

      print('Saved Image $_url');

      _savePetInDatabase(_url);
    }
  }

  Future _choosePicture() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
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
