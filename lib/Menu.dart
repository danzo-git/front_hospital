import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hospitalfront/Controller/PatientController.dart';
import 'package:hospitalfront/Vue/HomePage.dart';

class Menu extends StatefulWidget {
  final String userName;
  final String userEmail;
  final List<Widget>  ? otherAccountsPictures;

  const Menu({Key? key, required this.userName, required this.userEmail,  this.otherAccountsPictures}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final PatientController patientController = PatientController();
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(widget.userName),
      accountEmail: Text(widget.userEmail),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0),
      ),
      otherAccountsPictures: widget.otherAccountsPictures,
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
            title: const Text('Accueil'),
            onTap: () {}),
        ListTile(
          title: const Text('To page 2'),
        ),
        ListTile(
          title: const Text('Deconnexion'),
          leading: Icon(Icons.exit_to_app),
          onTap: () {},
        ),
      ],
    );

    return drawerItems;
  }
}