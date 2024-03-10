import 'package:flutter/material.dart';
import 'contact_details.dart';

class ContactList {
  String name;
  String phoneNumber;

  ContactList({ required this.name, required this.phoneNumber });
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<ContactList> contacts = [
    ContactList(name: 'John Doe', phoneNumber: '+12345'),
    ContactList(name: 'Tom Smith', phoneNumber: '+12345'),
    ContactList(name: 'Andrew Smith', phoneNumber: '+12345'),
  ];

  List<ContactList> filteredContacts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredContacts = contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0.5),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filteredContacts = contacts
                      .where((contact) =>
                          contact.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            filteredContacts = contacts;
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (BuildContext context, int index) {
                filteredContacts.sort((a, b) => a.name.compareTo(b.name));
                return ListTile(
                  title: Text(filteredContacts[index].name),
                  subtitle: Text(filteredContacts[index].phoneNumber),
                  onTap: () => {
                    _showContactDetails(context, filteredContacts[index]),
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    String name = '';
    String phoneNumber = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Contact', style: TextStyle(color: Colors.black)),
          content: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter name',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter phone number',
                ),
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                  setState(() {
                    contacts.add(ContactList(name: name, phoneNumber: phoneNumber));
                  });
                  Navigator.of(context).pop();
                } else {
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Name is required.')));
                  } else if (phoneNumber.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Phone number is required.')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Name and Phone number are required.')));
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showContactDetails(BuildContext context, ContactList contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailsPage(contact: contact),
      ),
    );
  }
}
