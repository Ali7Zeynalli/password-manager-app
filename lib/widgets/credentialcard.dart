import 'package:acharlarim/models/credential.dart';
import 'package:acharlarim/widgets/passworddialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CredentialCard extends StatelessWidget {
  final Credential credential;
  CredentialCard(this.credential);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).accentColor,
        ),
        child: ListTile(
          leading: Icon(
            IconData(credential.icon,
                fontFamily: "BrandIcons", fontPackage: "flutter_brand_icons"),
            color: Colors.white,
          ),
          title: Text(
            credential.title,
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.content_copy,
                color: Colors.white,
              ),
              onPressed: () => _copyToClipBoard(context)),
        ),
      ),
    );
  }

  _showDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return PasswordDialog(credential.key);
      },
    );
  }

  _copyToClipBoard(context) {
    Clipboard.setData(ClipboardData(text: credential.key));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.indigoAccent,
        content: Text(
          "Açar kopyalandı!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
