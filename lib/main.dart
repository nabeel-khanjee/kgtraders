import 'package:flutter/material.dart';
import 'package:radium_tech/Screens/Auth/sign_in.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/TaskListing/user_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userName = prefs.getString('user');
  var userId = prefs.getString('userid');

  runApp(
    MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(
        elevation: 10,
        shadowColor: appColor,
        backgroundColor:appColor.withOpacity(.6) ,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: appColor)
        )
      )),
      debugShowCheckedModeBanner: false,
      home: userName==null
          ? LoginScreen()
          : UserData(
              userId: userId!,
              userName: userName,
            ),
    ),
  );
}