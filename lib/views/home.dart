import 'package:flutter/material.dart';
import 'package:pawsapp/views/addPets.dart';
import 'package:pawsapp/views/payment.dart';
import 'package:pawsapp/views/pets.dart';
import 'package:pawsapp/views/schudle.dart';
import 'package:pawsapp/views/welcome.dart';
import 'package:pawsapp/my_app/globals.dart' as globals;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List<Widget> content = [Welcome(), Pets(), Schudle(), Payment()];
  TabController _tabController;

  void initState() {
    _tabController = new TabController(length: 4, vsync: this);

    globals.tabController = _tabController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(230, 152, 129, 1),
      extendBody: true,
      body: TabBarView(controller: _tabController, children: content),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(230, 152, 129, 1),
        onPressed: () {
          Navigator.of(context)
              .push((MaterialPageRoute(builder: (context) => AddPets())));
        },
        tooltip: 'Add Your Pets',
        child: Icon(Icons.add),
        elevation: 2.0,
        heroTag: 'add',
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
        child: BottomAppBar(
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.grey,
            indicatorColor: Color.fromRGBO(230, 152, 129, 1),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Padding(
                padding: EdgeInsets.only(right: 60.0),
                child: Tab(icon: Icon(Icons.pets)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Tab(icon: Icon(Icons.calendar_today)),
              ),
              Tab(icon: Icon(Icons.attach_money)),
            ],
          ),
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }
}
