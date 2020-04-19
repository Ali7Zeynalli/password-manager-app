import 'package:acharlarim/models/credential.dart';
import 'package:acharlarim/providers/general.dart';
import 'package:acharlarim/screens/add.dart';
import 'package:acharlarim/services/database.dart';
import 'package:acharlarim/widgets/credentialcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  DatabaseService databaseService = new DatabaseService();

  _getCredentials() async {
    return await databaseService.getCredentialList();
  }

  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(generalProvider.isDarkTheme
              ? Icons.brightness_7
              : Icons.brightness_4),
          onPressed: () => generalProvider.reverseTheme(),
        ),
        title: Text("Açarlarım"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => _navigateToAdd(context),
          ),
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: _getCredentials(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "...",
                  style: TextStyle(fontSize: 50.0),
                ),
              );
            }
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  "List boşdur.",
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }
            // print("snapshot:" + snapshot.data);
            return _displayCredentials(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget _displayCredentials(List<Credential> credentials) {
    return ListView.builder(
      itemCount: credentials.length,
      itemBuilder: (context, index) {
        return CredentialCard(credentials[index]);
      },
    );
  }

  void _navigateToAdd(context) => Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => Add()));
}
