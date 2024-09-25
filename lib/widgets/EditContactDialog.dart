import 'package:flutter/material.dart';

class EditContactDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function() onSave;

  const EditContactDialog({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Contact'),
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
            onSave(); // Call the save function
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
