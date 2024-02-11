import 'package:flutter/material.dart';

class ProfileTileWidget extends StatelessWidget {
  final String content;
  final IconData icon;
  const ProfileTileWidget({
    super.key,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          ListTile(
            tileColor: const Color.fromARGB(255, 114, 58, 124),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(content),
            leading: Icon(icon),
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
