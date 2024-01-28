import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contact.dart';
import '../utils/utils.dart';
import 'add_new_contact_page.dart';
import 'contact_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Contact convertJsonStringToContact(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString);

    final contact = Contact(
      firstName: map['firstName'],
      phone1: map['phone1'],
      color: map['color'],
    );

    contact.lastName = map['lastName'];
    contact.phone2 = map['phone2'];

    return contact;
  }

  Future<List<Contact>> readAllContactsFromCache() async {
    final cache = await SharedPreferences.getInstance();
    List<String>? stringList = cache.getStringList('contactsList');

    List<Contact> contacts = [];

    if (stringList != null) {
      for (int i = 0; i < stringList.length; i++) {
        final contact = convertJsonStringToContact(stringList[i]);
        contacts.add(contact);
      }
      return contacts;
    } else {
      return [];
    }
  }

  Future<void> writeNewContactToCache(Contact newContact) async {
    List<Contact> contactsInCache = await readAllContactsFromCache();
    contactsInCache.add(newContact);

    final cache = await SharedPreferences.getInstance();

    List<String> stringList = [];

    for (int i = 0; i < contactsInCache.length; i++) {
      String jsonString = contactsInCache[i].toJSONString();
      stringList.add(jsonString);
    }

    await cache.setStringList('contactsList', stringList);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddNewContactPage();
              },
            ),
          );

          if (result is Contact) {
            writeNewContactToCache(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: readAllContactsFromCache(),
        builder: (context, snapshot) {
          List<Contact>? contacts = snapshot.data;

          if (contacts == null || contacts.isEmpty) {
            return const Center(
              child: Text('There is no any contacts yet.'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 60),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactInfoPage(
                            contact: contact,
                          );
                        },
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () {
                      contacts.removeWhere(
                          (element) => element.firstName == contact.firstName);

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: getColor(contact.color),
                    foregroundColor: getTextColor(contact.color),
                    child: Text(contact.firstName[0]),
                  ),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                  subtitle: Text(contact.phone1),
                );
              },
            );
          }
        },
      ),
    );
  }
}
