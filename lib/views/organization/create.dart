import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import '../../../components/location_search_bar.dart';
import '../../commands/organization_command.dart';

class OrganizationCreate extends StatefulWidget {
  const OrganizationCreate({Key? key}) : super(key: key);

  @override
  State<OrganizationCreate> createState() => _OrganizationCreateState();
}

class _OrganizationCreateState extends State<OrganizationCreate> {
  final nameController = TextEditingController();
  final logoController = TextEditingController();
  late LocationSearchBar locationSearchBar;
  final Map<String, dynamic> locationInput = {
    "name": "",
    "latitude": 0,
    "longitude": 0,
  };
  @override
  initState() {
    locationSearchBar = LocationSearchBar(
      onCoordinatesChange: (coordinates, address) {
        locationInput['name'] = address;
        locationInput['latitude'] = coordinates.latitude;
        locationInput['longitude'] = coordinates.longitude;
      },
    );
    super.initState();
  }

  void createOrganization() async {
    print("createOrganization");
    try {
      Map<String, dynamic> createOrganizationInput = {
        'name': nameController.text.trim(),
        'roles': "{ORGANIZER}",
      };

      createOrganizationInput['location'] = locationInput;
      OrganizationCommand().createOrganization(createOrganizationInput);
    } on ApiException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Find Soccer Near You")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Profile();
              //   },
              // ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration.collapsed(hintText: 'Name'),
            ),
            locationSearchBar,
            GestureDetector(
              onTap: () {
                createOrganization();
              },
              child: const Text("tap me"),
            ),
          ],
        ),
      ),
    );
  }
}
