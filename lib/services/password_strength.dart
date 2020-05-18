import 'dart:math';

import 'package:flutter/material.dart';

double estimateBruteforceStrength(String password) {
  if (password.isEmpty) return 0.0;

  double charsetBonus;
  if (RegExp(r'^[a-z]*$').hasMatch(password)) {
    charsetBonus = 1.0;
  } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
    charsetBonus = 1.2;
  } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
    charsetBonus = 1.3;
  } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
    charsetBonus = 1.3;
  } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
    charsetBonus = 1.5;
  } else {
    charsetBonus = 1.8;
  }

  final logisticFunction = (double x) {
    return 1.0 / (1.0 + exp(-x));
  };

  final curve = (double x) {
    return logisticFunction((x / 3.0) - 4.0);
  };

  return curve(password.length * charsetBonus);
}

Text passwordStrength(String password) {
  double passwordStrengthValue = estimateBruteforceStrength(password);
  print(passwordStrengthValue);
  Color color;
  String text;

  if (passwordStrengthValue > .9) {
    text = "very strong";
    color = Colors.green;
  } else if (passwordStrengthValue < .9 && passwordStrengthValue > .6) {
    text = "medium";
    color = Colors.orange;
  } else if (passwordStrengthValue < .6 && passwordStrengthValue > .2) {
    text = "weak";
    color = Colors.redAccent;
  } else if (passwordStrengthValue < .2) {
    text = "very weak";
    color = Colors.red;
  }

  return Text(
    text,
    style: TextStyle(color: color, fontSize: 18.0),
  );
}
