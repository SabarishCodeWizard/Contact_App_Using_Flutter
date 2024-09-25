import 'package:flutter/material.dart';

class ContactSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> contacts;
  final Function(String) onContactTap;

  ContactSearchDelegate({required this.contacts, required this.onContactTap});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> results = contacts
        .where((contact) => contact['name'].toLowerCase().contains(query.toLowerCase()) || 
                             contact['phone'].contains(query))
        .toList();

    return _buildSuggestions(results, context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = contacts
        .where((contact) => contact['name'].toLowerCase().contains(query.toLowerCase()) || 
                             contact['phone'].contains(query))
        .toList();

    return _buildSuggestions(suggestions, context);
  }

  // Build the list of suggestions/results
  Widget _buildSuggestions(List<Map<String, dynamic>> contactList, BuildContext context) {
    if (contactList.isEmpty) {
      return const Center(
        child: Text('No contacts found.'),
      );
    }

    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        final contact = contactList[index];
        return ListTile(
          title: Text(contact['name']),
          subtitle: Text(contact['phone']),
          onTap: () {
            onContactTap(contact['phone']); // Call the contact
            close(context, null); // Close the search delegate
          },
        );
      },
    );
  }
}
