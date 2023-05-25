import 'package:flutter/material.dart';

class Catalogue extends StatefulWidget {

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {

  late String image_adress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black87),
      onPressed: () {
      }, child: Container(
      height:400 , width: 150,
        margin: EdgeInsets.all(10.0),
        child:
        Image(image: AssetImage('assets/background_1.png', ),
          fit: BoxFit.fill,
        )
    ),

    );
  }
}
