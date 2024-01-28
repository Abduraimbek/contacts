import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../utils/utils.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final avatarRadius = width / 6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Info'),
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundColor: getColor(contact.color),
            foregroundColor: getTextColor(contact.color),
            radius: avatarRadius,
            child: Text(
              contact.firstName[0],
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              '${contact.firstName} ${contact.lastName}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.phone),
            title: Text(contact.phone1),
            subtitle: const Text('Phone 1'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.phone),
            title: Text(contact.phone2.toString()),
            subtitle: const Text('Phone 2'),
          ),
        ],
      ),
    );
  }
}
