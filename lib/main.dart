import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'widgets/ContactList.dart';
import 'widgets/ContactSearchDelegate.dart';
import 'widgets/AddContactDialog.dart';
import 'widgets/EditContactDialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone App',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> contacts = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int _selectedIndex = 1;

  void _addContact() {
    setState(() {
      contacts.add({
        'name': nameController.text,
        'phone': phoneController.text,
        'time': TimeOfDay.now().format(context),
        'isFavorite': false,
      });
      nameController.clear();
      phoneController.clear();
    });
    Navigator.of(context).pop();
  }

  void _editContact(int index) {
    setState(() {
      contacts[index]['name'] = nameController.text;
      contacts[index]['phone'] = phoneController.text;
      nameController.clear();
      phoneController.clear();
    });
    Navigator.of(context).pop();
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      contacts[index]['isFavorite'] = !contacts[index]['isFavorite'];
    });
  }

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  print('Trying to launch: $phoneUri'); // Debug log
  
  try {
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Cannot launch $phoneUri'); // Debug log
      throw 'Could not launch $phoneNumber';
    }
  } catch (e) {
    print('Error: $e'); // Catch and log any errors
  }
}


  Widget _getPageContent() {
    if (_selectedIndex == 0) {
      return ContactList(
        contacts: contacts,
        onLongPress: (index) {
          showDialog(
            context: context,
            builder: (context) {
              return EditContactDialog(
                nameController: nameController..text = contacts[index]['name'],
                phoneController: phoneController..text = contacts[index]['phone'],
                onSave: () => _editContact(index),
              );
            },
          );
        },
        onCall: _makePhoneCall,
      );
    }
    return Center(child: Text('Other page content'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(
                  contacts: contacts,
                  onContactTap: _makePhoneCall,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddContactDialog(
                    nameController: nameController,
                    phoneController: phoneController,
                    onAdd: _addContact,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _getPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
