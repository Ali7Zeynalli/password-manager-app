import 'package:flutter/material.dart';

class Credential {
  int id;
  int icon;
  String title;
  String key;

  Credential({
    this.icon,
    this.title,
    this.key,
  });

  Credential.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    icon = map["icon"];
    title = map["title"];
    key = map["key"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "icon": icon,
      "title": title,
      "key": key,
    };
  }

  String toString() => "$id $icon, $title, $key";
}
