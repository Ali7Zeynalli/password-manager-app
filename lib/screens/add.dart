import 'package:acharlarim/models/credential.dart';
import 'package:acharlarim/providers/general.dart';
import 'package:acharlarim/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:acharlarim/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class Add extends StatelessWidget {
  final DatabaseService databaseService = new DatabaseService();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController keyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final generalProvider = Provider.of<General>(context);

    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            _chooseIcon(context, generalProvider),
            Divider(),
            _titleField(context),
            Divider(),
            _passwordField(context),
            Divider(),
            _addButton(context, generalProvider),
          ],
        ),
      ),
    );
  }

  Widget _addButton(BuildContext context, General generalProvider) {
    return Builder(
      builder: (context) => FlatButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).primaryColor,
        icon: Icon(Icons.add_box, color: Colors.white),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ADD",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        onPressed: () => _save(
          generalProvider.iconData,
          titleController.text,
          keyController.text,
          context,
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: keyController,
      decoration: InputDecoration(
        hintText: "Password1234_",
        helperText: "Password",
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _titleField(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        hintText: "facebook, instagram, gmail..",
        helperText: "Title",
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor, style: BorderStyle.solid),
        ),
      ),
    );
  }

  Widget _chooseIcon(BuildContext context, General generalProvider) {
    return Row(
      children: <Widget>[
        Text(
          "Icon:",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 10),
        DropdownButton(
          hint: Icon(generalProvider.iconData),
          items: _iconsList
              .map(
                (IconData icon) => DropdownMenuItem<IconData>(
                  value: icon,
                  child: Icon(icon),
                ),
              )
              .toList(),
          onChanged: (selectedIconData) =>
              generalProvider.iconData = selectedIconData,
        ),
      ],
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Add Password"),
      elevation: 0.0,
    );
  }

  void _save(IconData iconData, String title, String key, context) async {
    if (iconData != null && title != null && key != null) {
      
      Provider.of<General>(context, listen: false).clearIconData();

      Credential credential = new Credential(
        icon: iconData.codePoint,
        title: title,
        key: key,
      );
      final result = await databaseService.insert(credential);
      print(result);
      if (result != null) {
        CustomSnackBar.display(text: "Password added", context: context);
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
      }
    } else {
      CustomSnackBar.display(text: "Fill all the fields", context: context);
    }
  }

  List<IconData> _iconsList = <IconData>[
    BrandIcons.facebook,
    BrandIcons.gmail,
    BrandIcons.android,
    BrandIcons.googleplay,
    BrandIcons.tiktok,
    BrandIcons.windows,
    BrandIcons.mailDotRu,
    BrandIcons.instagram,
    BrandIcons.twitter,
    BrandIcons.youtube,
    BrandIcons.udacity,
    BrandIcons.mastercard,
    BrandIcons.yahoo,
    BrandIcons.visa,
    BrandIcons.udemy,
    BrandIcons.uber,
    BrandIcons.vk,
    BrandIcons.patreon,
    BrandIcons.apple,
    BrandIcons.linkedin,
    BrandIcons.ebay,
    BrandIcons.adobe,
    BrandIcons.airbnb,
    BrandIcons.amazon,
    BrandIcons.amazonaws,
    BrandIcons.americanexpress,
    BrandIcons.apache,
    BrandIcons.applepay,
    BrandIcons.babel,
    BrandIcons.behance,
    BrandIcons.bitbucket,
    BrandIcons.bitcoin,
    BrandIcons.bitly,
    BrandIcons.blogger,
    BrandIcons.buymeacoffee,
    BrandIcons.buzzfeed,
    BrandIcons.canva,
    BrandIcons.codepen,
    BrandIcons.dailymotion,
    BrandIcons.deezer,
    BrandIcons.discord,
    BrandIcons.duckduckgo,
    BrandIcons.ethereum,
    BrandIcons.evernote,
    BrandIcons.figma,
    BrandIcons.filezilla,
    BrandIcons.firebase,
    BrandIcons.github,
    BrandIcons.gitlab,
    BrandIcons.googlepay,
    BrandIcons.java,
    BrandIcons.livejournal,
    BrandIcons.quora,
    BrandIcons.wattpad,
    BrandIcons.wechat,
    BrandIcons.wikipedia,
    BrandIcons.wix,
    BrandIcons.wordpress,
    BrandIcons.reddit,
    BrandIcons.teamviewer,
    BrandIcons.tencentqq,
    BrandIcons.tencentweibo,
    BrandIcons.tor,
    BrandIcons.tinder,
    BrandIcons.twitch,
    BrandIcons.tumblr,
    BrandIcons.tripadvisor,
    BrandIcons.yammer,
    BrandIcons.yandex,
    BrandIcons.yelp,
    BrandIcons.unsplash,
    BrandIcons.govDotUk,
    BrandIcons.icloud,
    BrandIcons.icq,
    BrandIcons.oracle,
    BrandIcons.paypal,
    BrandIcons.podcasts,
    BrandIcons.pluralsight,
    BrandIcons.periscope,
    BrandIcons.xbox,
    BrandIcons.viber,
    BrandIcons.vimeo,
    BrandIcons.microsoft,
    BrandIcons.medium,
    BrandIcons.meetup
  ];
}
