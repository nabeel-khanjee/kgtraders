import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:radium_tech/Components/form_button.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Screens/TaskListing/user_list.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/location/get_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/Auth/login_api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Location location = Location();

  final inputFieldColor = Color.fromARGB(40, 158, 158, 158);

  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    GetLocationState().getLocation();
    location.getLocation();
  }

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var member_email;
  var member_password;
  bool showPassword = true;

  TextEditingController emaiController = TextEditingController();

  bool _checkLogin = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          
          image: DecorationImage(

            fit: BoxFit.fitHeight,

            image: AssetImage(

              
              'assets/photo-1519602985774-5ca448b50061.jpg'
              ),
              
              )),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                      width: size.width * 0.6,
                      image: AssetImage(
                        "assets/kg-logo.png",
                      )),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 50,
                      shadowColor: appColor.withOpacity(0.5),
                      // color: c.withOpacity(.5),
                      color: Colors.white.withOpacity(.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.03),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appColor,
                                  fontSize: 36),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: inputFieldColor,
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 5),
                                      child: TextFormField(
                                          style: TextStyle(
                                            color:
                                                appColor,
                                          ),
                                          controller: emaiController,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                              color: appColor,
                                            ),
                                            prefixIcon: Icon(Icons.email,
                                               color: appColor),
                                            border: InputBorder.none,
                                            labelText: 'Email',
                                          ))))),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              alignment: const Alignment(0, 0),
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                      color: inputFieldColor,
                                      borderRadius: new BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                            controller: passwordController,
                                            style: TextStyle(
                                              color: appColor,
                                            ),
                                            obscureText: showPassword,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                               prefixIcon: Icon(Icons.lock,
                                               color: appColor),
                                             labelText: 'Password',
                                                labelStyle: TextStyle(
                                                  color:appColor,
                                                ))))),
                                Positioned(
                                    right: 15,
                                    child: IconButton(
                                        onPressed: () {
                                     
                                          if (showPassword) {
                                            setState(() {
                                              showPassword = false;
                                            });
                                          } else {
                                            setState(() {
                                              showPassword = true;
                                            });
                                          }
                                        },
                                        icon: showPassword
                                            ? Icon(
                                                Icons.visibility,
                                               color: appColor
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                               color: appColor
                                              )))
                              ],
                            ),
                          ),
                    
                          SizedBox(height: 10),
                          FormButton(
                              buttonTitle: "\t\tLogin\t\t",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                              iconData: Icons.login),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_checkLogin ? "" : "Username or password is invalid",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
      _checkLogin = true;
    });
    var data = {'email': emaiController.text, 'password': passwordController.text};
    print(data);

    var res = await Network().authData(data, '/signin');
    print(res);
    var body = jsonDecode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user'.toString(), (body['username']));
      localStorage.setString('userid', json.encode(body['userid']));

      var username = body['username'];
      var userId = localStorage.getString('userid');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserData(
            userId: userId!,
            userName: username!,
          ),
        ),
      );
      _checkLogin = true;
    } else {
      showToastAppFalse();
      _checkLogin = false;
    }

    setState(() {
      _isLoading = false;
    });
  }
}
