import 'package:flutter/material.dart';
import '../../services/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, new Suggestion("", ""));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 300.0,
    );
  }

  dynamic getSnapshot(AsyncSnapshot snapshot)  {   
    print("getSnapshot"); 
    dynamic alternateResult = snapshot.requireData;


    return alternateResult;
  }

  

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: null,
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title:
                        // Text(snapshot.req != null snapshot.requireData[index] : ''),
                        Text(getSnapshot(snapshot)[index]),
                    onTap: () {
                      close(context, getSnapshot(snapshot).data[index]);
                    },
                  ),
                  itemCount: getSnapshot(snapshot).data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}