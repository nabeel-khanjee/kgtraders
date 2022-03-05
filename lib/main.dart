import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Screens/Auth/sign_in.dart';
import 'package:radium_tech/Services/base_url.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/TaskListing/user_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'K.G.Traders',
      
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
      theme: ThemeData(
        
          appBarTheme: AppBarTheme(
        color: appColor,
        centerTitle: true,
        
      )),
    );
  }
}

class AppUrlChange extends StatefulWidget {
  AppUrlChange({Key? key}) : super(key: key);

  @override
  State<AppUrlChange> createState() => _AppUrlChangeState();
}

class _AppUrlChangeState extends State<AppUrlChange> {
  var urls = ['http://192.168.18.65:8000','http://127.0.0.1:8000', 'https://testerp.radiumpk.com'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormBuilderDropdown(
              name: "urls",
              decoration: inputDecoration("Url", ""),
              items: urls
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text('$value'),
                      ))
                  .toList(),
              onChanged: (value) {
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckAuth()));
              },
              child: Text("Go to login Screen"),
            )
          ],
        ),
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  String username = '';
  String userid = '';

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userName = localStorage.getString('username');
    var userId = localStorage.getString('userid');

    setState(() {
      username = userName!;
      userid = userId!;
    });

    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = UserData(
        userId: userid,
        userName: username,
      );
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}
