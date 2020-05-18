import 'package:acharlarim/models/credential.dart';
import 'package:acharlarim/widgets/password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acharlarim/widgets/custom_snackbar.dart';

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
          leading: _icon(),
          title: _title(),
          trailing: _copyButton(context),
        ),
      ),
    );
  }

  Widget _copyButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.content_copy,
          color: Colors.white,
        ),
        onPressed: () => _copyToClipBoard(context));
  }

  Widget _title() {
    return Text(
      credential.title,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _icon() {
    return Icon(
      IconData(
        credential.icon,
        fontFamily: "BrandIcons",
        fontPackage: "flutter_brand_icons",
      ),
      color: Colors.white,
    );
  }

  _showDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return PasswordDialog(credential.key, credential.id);
      },
    );
  }

  _copyToClipBoard(context) {
    Clipboard.setData(ClipboardData(text: credential.key));
    CustomSnackBar.display(text: "Copied to Clipboard", context: context);
  }
}
