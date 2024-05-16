import 'package:crud_flutter_app/services/firebase_service.dart';

import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final String id;
  const EditProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final FireStoreService firebaseService = FireStoreService("products");

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final value = await firebaseService.getDatabyId(widget.id);
    nameController.text = value?["name"] ?? "name";
    descriptionController.text = value?["description"] ?? "desc";
    priceController.text = value?["price"] ?? "price";
    debugPrint(value.toString());
    setState(() {});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await firebaseService.updateData(widget.id, {
                  "name": nameController.text,
                  "description": descriptionController.text,
                  "price": priceController.text
                });
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Edit Product"),
            ),
          )
        ],
      ),
    );
  }
}
