import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  final Function(int) onLongPress;
  final Function(String) onCall;

  const ContactList({
    Key? key,
    required this.contacts,
    required this.onLongPress,
    required this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(
        child: Text('No contacts found.'),
      );
    }

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(contact['name'][0]), // Display first letter
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact['name']),
                Text('${contact['phone']} • ${contact['time']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    contact['isFavorite'] ? Icons.star : Icons.star_border,
                    color: contact['isFavorite'] ? Colors.yellow : Colors.white,
                  ),
                  onPressed: () => contact['toggleFavorite'](), // Toggle favorite
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () => onCall(contact['phone']), // Make call
                ),
              ],
            ),
            onLongPress: () => onLongPress(index), // Long press to show options
          ),
        );
      },
    );
  }
}
