import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double width;
  // final IconData iconData;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.width,
    // required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: Card(
        color: Colors.blueGrey.shade100,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Icon(iconData, size: 40),
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
