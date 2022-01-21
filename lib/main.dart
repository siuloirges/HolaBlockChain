// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_frist_dapp/pages/HomePage.dart';
import 'package:my_frist_dapp/utils/ApiConectionProvider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiConectionProvider(),
        ),
      ],
      child: OKToast(
        handleTouch: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: HomePage(),
          theme: ThemeData(
            errorColor: Colors.black,
            primaryColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
