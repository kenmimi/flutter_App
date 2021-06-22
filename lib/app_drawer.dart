import 'package:flutter/material.dart';
import 'package:flutter_app/camera.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/tracking.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.blue,
                    Colors.blue
                  ])
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(padding: EdgeInsets.all(8.0),
                        child: Image.asset('images/image.jpg', width: 80,height: 80,),),
                    ),
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Text('Mimi',style: TextStyle(color: Colors.white,fontSize: 20.0),),)
                  ],
                ),
              )),
          CustomListTile(Icons.camera,'photo',()=>{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Camera()))
          }),
          CustomListTile(Icons.map,'geolocalisation',()=>{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Locator()))
          }),
          CustomListTile(Icons.list,'money track',()=>{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Tracking()))
          }),
        ],
      ),
    );
  }
}


class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:Colors.grey.shade400))
        ),
        child: InkWell(
          splashColor: Colors.blue,
          onTap: onTap,
          child: Container(
            height: 50 ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }

}