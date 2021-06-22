import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_drawer.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title:'Drawer App',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text('Drawer'),
       backgroundColor: Colors.blue,
     ),
      drawer: AppDrawer(),
      body: Center(child: Text("Hello"))
    );
  }
}



