import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import '../../commands/event_command.dart';

class EventCreate extends StatefulWidget {
  const EventCreate({Key? key}) : super(key: key);

  @override
  State<EventCreate> createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final capacityController = TextEditingController();
  bool _isLoading = false;

  Future<Map<String, dynamic>> createEvent() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> createEventInput = {
        "name": nameController.text.trim(),
        "secondaryName": secondaryNameController.text.trim(),
        "address": addressController.text.trim(),
        "surface": surfaceController.text.trim(),
        "images": imageController.text.trim(),
        "fieldSize": fieldSizeController.text.trim(),
        "capacity": capacityController.text.trim(),
        "private": privateController.text.trim()
      };
      Map<String, dynamic> createEventRes =
          await EventCommand().createEvent(createEventInput);
      if (createEventRes['success']) {
        createPickupGameResponse['success'] = true;
        createPickupGameResponse['data'] = createEventRes['data'];
      }
      setState(() {
        _isLoading = false;
      });
      return createPickupGameResponse;
    } on ApiException {
      return createPickupGameResponse;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.orange.shade500,
        title: const Text("Create Event"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                hintText: 'Image',
                labelText: 'Image',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: secondaryNameController,
              decoration: const InputDecoration(
                hintText: 'Secondary Name',
                labelText: 'Secondary Name',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Address',
                labelText: 'Address',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: surfaceController,
              decoration: const InputDecoration(
                hintText: 'Surface',
                labelText: 'Surface',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: fieldSizeController,
              decoration: const InputDecoration(
                hintText: 'Field Size',
                labelText: 'Field Size',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: privateController,
              decoration: const InputDecoration(
                hintText: 'Private',
                labelText: 'Private',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: capacityController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                hintText: 'Event Capacity',
                labelText: 'Event Capacity',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            FilledButton(
              onPressed: () {
                createEvent();
              },
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text("Create Event"),
            ),
          ],
        ),
      ),
    );
  }
}
