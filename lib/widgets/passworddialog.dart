import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordDialog extends StatelessWidget {
  final String _key;
  PasswordDialog(this._key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).accentColor,

      // elevation: 0.0,
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
            Icon(
              Icons.vpn_key,
              color: Colors.white,
              size: 40.0,
            ),
            Divider(color: Colors.white),
            InkWell(
              onTap: () => Clipboard.setData(ClipboardData(text: _key)),
              child: Text(
                _key,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Divider(color: Colors.white),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Container(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
