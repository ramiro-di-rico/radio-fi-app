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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 30,
              errorBuilder: (context, o, trace) {
                return Icon(Icons.radio_sharp);
              },
            ),
          ),
        ),
      ],
    );
  }
}
