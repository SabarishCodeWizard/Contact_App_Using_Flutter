import 'package:flutter/material.dart';

class AddContactDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function() onAdd;

  const AddContactDialog({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onAdd(); // Call the add function
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
