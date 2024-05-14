import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String imagePath;
  final String route;

  const NavigationButton({
    Key? key,
    required this.imagePath,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Ink.image(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            width: 56.0,
            height: 56.0,
          ),
        ),
      ),
    );
  }
}
