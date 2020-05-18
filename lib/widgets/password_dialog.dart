import 'package:acharlarim/services/database.dart';
import 'package:acharlarim/services/password_strength.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:acharlarim/widgets/custom_snackbar.dart';

class PasswordDialog extends StatelessWidget {
  final String _key;
  final int id;
  PasswordDialog(this._key, this.id);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height / 3,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _keyIcon(),
            Divider(color: Colors.white),
            InkWell(
              onTap: () => Clipboard.setData(ClipboardData(text: _key)),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "$_key",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            passwordStrength(_key),
            Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _deleteButton(context),
                _closeButton(context),
                _copyButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _copyButton(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: _key));
          // CustomSnackBar.display(text: "Copied to Clipboard", context: context);
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
        },
        icon: Icon(
          Icons.content_copy,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.close,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return IconButton(
      onPressed: () => _deleteDialog(context, id),
      icon: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Icon _keyIcon() {
    return Icon(
      Icons.vpn_key,
      color: Colors.white,
      size: 40.0,
    );
  }

  void _deleteDialog(context, id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Delete?",
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("NO", style: Theme.of(context).textTheme.body1),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                color: Colors.black,
                child: Text(
                  "YES",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _delete(id, context),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      },
    );
  }

  _delete(int id, context) async {
    DatabaseService databaseService = new DatabaseService();
    final result = await databaseService.delete(id);
    if (result != null) {
      CustomSnackBar.display(text: "Password deleted", context: context);
    }
  }
}
