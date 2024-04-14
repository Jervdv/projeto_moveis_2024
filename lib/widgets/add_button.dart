import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String imagePath;

  const AddButton({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent, // Button color
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30), // Splash color
          onTap: () {
            Navigator.pushNamed(context, '/new_entry');
          },
          child: Ink.image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            width: 56.0, // Button size
            height: 56.0,
          ),
        ),
      ),
    );
  }
}
