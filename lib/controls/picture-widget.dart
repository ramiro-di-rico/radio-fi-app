import 'package:flutter/material.dart';

class PictureWidget extends StatelessWidget {

  final String imageUrl; 
  
  PictureWidget(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.network(imageUrl, 
            width: 40,
          )
        ),
      ],
    );
  }
}