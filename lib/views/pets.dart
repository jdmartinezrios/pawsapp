import 'package:flutter/material.dart';
import 'package:pawsapp/fonts/my_flutter_app_icons.dart';
import 'package:pawsapp/views/addPets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editPets.dart';
import 'package:transparent_image/transparent_image.dart';

class Pets extends StatefulWidget {
  @override
  PetsPage createState() => PetsPage();
}

class PetsPage extends State<Pets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 152, 129, 1),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: double.infinity,
              child: Text('Your Pets',
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
                Navigator.of(context)
                    .push((MaterialPageRoute(builder: (context) => AddPets())));
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
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            // children: <Widget>[
            child: _buildPetsList(),
            // ListView(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.vertical,
            //   children: <Widget>[
            //     _buildCards('Max', 'Golden Retriever', '3 Years Old',
            //         'assets/pet1.png'),
            //     _buildCards(
            //         'Coco', 'Bordier Collie', '6 Years Old', 'assets/pet2.png'),
            // _buildCards('Max', 'Golden Retriever', '3 Years Old',
            //     'assets/pet1.png'),
            // _buildCards(
            //     'Coco', 'Bordier Collie', '6 Years Old', 'assets/pet2.png'),
            // _buildCards('Max', 'Golden Retriever', '3 Years Old',
            //     'assets/pet1.png'),
            // _buildCards(
            //     'Coco', 'Bordier Collie', '6 Years Old', 'assets/pet2.png'),
            // _buildCards('Max', 'Golden Retriever', '3 Years Old',
            //     'assets/pet1.png'),
            // _buildCards(
            //     'Coco', 'Bordier Collie', '6 Years Old', 'assets/pet2.png'),
            //   ],
            // ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }

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
        return new PetsList(document: snapshot.data.documents);
      },
    );
  }
}

class PetsList extends StatefulWidget {
  PetsList({this.document});
  final List document;

  PetsListState createState() => PetsListState();
}

class PetsListState extends State<PetsList> {
  // PetsList({this.document});
  // final List document;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.document.length,
      itemBuilder: (BuildContext ctx, int i) {
        String name = widget.document[i].data['name'].toString();
        String breed = widget.document[i].data['breed'].toString();
        String years = widget.document[i].data['ages'].toString();
        String image = widget.document[i].data['image'].toString();
        String sexo = widget.document[i].data['sex'].toString();

        return _buildCards(
            name, breed, years, image, sexo, widget.document[i].reference);
      },
    );
  }

  Widget _buildCards(
          String name, breed, years, image, sexo, DocumentReference idPets) =>
      InkWell(
        onTap: () {
          print('press action');
          Navigator.of(context).push(
            (MaterialPageRoute(
              builder: (context) => EditPets(
                heroTag: image,
                name: name,
                breed: breed,
                age: years,
                sex: sexo,
                idPet: idPets,
              ),
            )),
          );
        },
        child: Hero(
          tag: image,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 5 / 100,
                right: MediaQuery.of(context).size.width * 5 / 100),
            child: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  // left: 20,
                  left: MediaQuery.of(context).size.width * 5 / 100,
                  top: 15,
                  child: Container(
                    height: 120,
                    width: 110,
                    // width: MediaQuery.of(context).size.width * 30 / 100,
                    decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage(image), fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: <Widget>[
                          Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(230, 152, 129, 1),
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            // child: Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: image,
                              fit: BoxFit.cover,
                            ),
                            // ),
                          ),
                        ],
                      ),
                      // Image.network(
                      //   image,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 126, top: 26),
                  // left: 128,
                  // left: MediaQuery.of(context).size.width * 35 / 100
                  height: 100,
                  // width: 190,
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 30, bottom: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                  color: Color.fromRGBO(230, 152, 129, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              breed,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left,
                            ),
                            Container(margin: EdgeInsets.only(top: 20.0)),
                            Text(
                              '$years Years Old',
                              style:
                                  TextStyle(fontFamily: 'Open Sans',color: Color.fromRGBO(170, 170, 170, 1), fontSize: 10.0),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  // }
}
