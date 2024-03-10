import 'package:flutter/material.dart';
import 'contacts_page.dart';

class ContactDetailsPage extends StatelessWidget {
  final ContactList contact;

  const ContactDetailsPage({required this.contact}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set icon (arrow) color to white
        ),
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left) of the cross axis
          children: [
            Center(
              child: Text(contact.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22
              ),
            )
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[800],
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'mobile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(contact.phoneNumber,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )          
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
