import 'package:acharlarim/models/credential.dart';
import 'package:acharlarim/providers/general.dart';
import 'package:acharlarim/screens/add.dart';
import 'package:acharlarim/screens/settings.dart';
import 'package:acharlarim/services/database.dart';
import 'package:acharlarim/widgets/credential_card.dart';
import 'package:acharlarim/widgets/scale_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final DatabaseService databaseService = new DatabaseService();

  _getCredentials() async {
    return await databaseService.getCredentialList();
  }

  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context);
    return Scaffold(
      appBar: _appBar(context, generalProvider),
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: _getCredentials(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return _noSavedData();
              } else {
                return _displayCredentials(snapshot.data);
              }
            }
            return _loadingIndicator();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _addButton(context),
    );
  }

  Widget _noSavedData() {
    return Center(
      child: Text(
        "No saved passwords, yet.",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Text(
        "...",
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }

  FloatingActionButton _addButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).accentColor,
      onPressed: () => _navigateToAdd(context),
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _appBar(BuildContext context, General generalProvider) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.vpn_key),
        onPressed: () => _navigateToSettings(context),
      ),
      title: Text("Pass-Man"),
      actions: <Widget>[
        IconButton(
          icon: Icon(generalProvider.isDarkTheme
              ? Icons.brightness_7
              : Icons.brightness_4),
          onPressed: () => generalProvider.reverseTheme(),
        )
      ],
      elevation: 0.0,
      centerTitle: true,
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

  void _navigateToAdd(context) =>
      Navigator.of(context).push(ScaleRoute(widget: Add()));

  void _navigateToSettings(context) => Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => Settings()));
}
