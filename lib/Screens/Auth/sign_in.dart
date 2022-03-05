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
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _checkLogin = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Container(
            
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    width: size.width * 0.6,
                    image: AssetImage(
                      "assets/kg-logo.png",
                    )),
                SizedBox(height: 22,),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(vertical: 34),
                  decoration: BoxDecoration(
                      border: Border.all(color: appColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: appColor.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.03),
                      Container(
                        // alignment: Alignment.centerLeft,
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
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return 'Please enter email';
                              }
                              member_email = emailValue;
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                inputDecoration("Email", "Enter the email")),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (passwordValue) {
                            if (passwordValue!.isEmpty) {
                              return 'Please Enter Password';
                            }
                            member_password = passwordValue;
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration:
                              inputDecoration("Password", "Enter the password"),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                     FormButton( buttonTitle: "\t\tLogin\t\t", onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          }, iconData: Icons.login)
                     ,
                      // Container(
                      //   // alignment: Alignment.centerRight,
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 40, vertical: 10),
                      //   child: RaisedButton(
                      //     color: appColor,
                      //     onPressed: () {
                      //       if (_formKey.currentState!.validate()) {
                      //         _login();
                      //       }
                      //     },
            
                      //     // shape: RoundedRectangleBorder(
            
                      //     //     borderRadius: BorderRadius.circular(80.0)),
                      //     textColor: Colors.white,
                      //     padding: const EdgeInsets.all(0),
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       height: 60.0,
                      //       width: size.width * 0.8,
                      //       padding: const EdgeInsets.all(0),
                      //       child: const Text(
                      //         "LOGIN",
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text(_checkLogin ? "" : "Username or password is invalid",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
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
    var data = {'email': member_email, 'password': member_password};
    print(data);

    var res = await Network().authData(data, '/signin');
    print(res);
    var body = jsonDecode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['username']));
      localStorage.setString('userid', json.encode(body['userid']));

      var username = body['username'];
      var userId = localStorage.getString('userid');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserData(
                  userId: userId!,
                  userName: username!,
                )),
      );
      _checkLogin = true;
    } else {
      showToastAppFalse();
      //(body['message']);
      _checkLogin = false;
    }

    setState(() {
      _isLoading = false;
    });
  }
/*  void logIn() async{

    if(passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse('https://testerp.radiumpk.com/signin'),
      body: ({
        'email': emailController.text,
        'password': passController.text
      })
      );
      if(response.statusCode == 200) {
        final body = jsonDecode(response.body);
        errorSnackBar(context, 'Succefully Login ${body['']}');
        pageRoute(body!['token']);
       // Map<String,dynamic>user=response['data'];
        //savePref(user['survey_id']);
        print(savePref);


      } else {
        errorSnackBar(context, 'Invalid Credential');
      }
    }else {
      errorSnackBar(context, 'empty');
    }

  }
  void pageRoute(String token) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('signin', token);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>  UserData(),
        ));

  }
  savePref(int survey_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("survey_id", survey_id);

    preferences.commit();

  }*/
}
