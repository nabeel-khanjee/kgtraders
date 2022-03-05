import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:radium_tech/Components/box_shadow_for_app.dart';
import 'package:radium_tech/Model/task_listing_model.dart';
import 'package:radium_tech/Screens/ResidenceForm/myhome.dart';
import 'package:radium_tech/Services/ListingData/get_servey_listing.dart';
import 'package:radium_tech/Screens/Auth/sign_in.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/location/get_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key, required this.userName, required this.userId})
      : super(key: key);
  final String userName;
  final String userId;
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  GetSurveyListing getSurveyListing = GetSurveyListing();
  Future<Welcome>? userListing;
  Location location = Location();

  @override
  initState() {
    super.initState();
    GetLocationState().getLocation();
    location.getLocation();

    userListing = getSurveyListing.getList('/getSurveys/${widget.userId}');
  }

  bool shouldPop = true;
  @override
  void dispose() {
    print("Disposing second route");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon customIcon = const Icon(Icons.search);
    Widget customSearchBar = const Text('My Personal Journal');

    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text(widget.userName),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image(image: AssetImage("assets/kg-logo.png"))),
              ListTile(
                trailing: Icon(
                  Icons.person,
                  color: appColor,
                ),
                title: Text(
                  widget.userName,
                  style: TextStyle(color: appColor),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.logout,
                  color: appColor,
                ),
                title: Text('Logout', style: TextStyle(color: appColor)),
                onTap: () {
                  logout();
                },
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreashData,
          child: FutureBuilder<Welcome>(
            future: userListing,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.data!.isEmpty) {
                  return ListView(children: [
                    Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.5),
                            child: const Text(
                              "No Job Found",
                            ),
                          )
                        ]))
                  ]);
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        var listData = snapshot.data!.data![index];
                        return Column(children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (snapshot.data!.data![index].type ==
                                  "Workplace") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePageResidence(
                                             isHrDetails: snapshot.data!.data![index].isHr!,
                                            isSalarySlip: snapshot.data!.data![index].isSlip!,
                                       formFormate: "1",
                                        userId: widget.userId,
                                        userName: widget.userName,
                                        surveyId: listData.surveyId!,
                                      ),
                                    ));
                              } else if(snapshot.data!.data![index].type=="Residence") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePageResidence(
                                            isHrDetails: 0,
                                            isSalarySlip: 0,
                                        formFormate: "2",
                                        userId: widget.userId,
                                        userName: widget.userName,
                                        surveyId: listData.surveyId!,
                                      ),
                                    ));
                              } else if(snapshot.data!.data![index].type=="Bank Statement") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePageResidence(
                                            isHrDetails: 0,
                                            isSalarySlip: 0,
                                        formFormate: "3",
                                        userId: widget.userId,
                                        userName: widget.userName,
                                        surveyId: listData.surveyId!,
                                      ),
                                    ));
                              }else{
                                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePageResidence(
                                            isHrDetails: 0,
                                            isSalarySlip: 0,
                                        formFormate: "4",
                                        userId: widget.userId,
                                        userName: widget.userName,
                                        surveyId: listData.surveyId!,
                                      ),
                                    ));
                          
                              }
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(boxShadow: [boxShadowForApp()]),
                              margin: EdgeInsets.all( 8),
                              child: Card(
                                margin: EdgeInsets.only(top: 15),
                                shadowColor: appColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 70,
                                      child: Image.network(
                                        listData.bankImg != null
                                            ? listData.bankImg!
                                            : "http://radiumpk.com/wp-content/uploads/2019/09/radium-logo-2.png",
                                        fit: BoxFit.contain,
                                        width: 52,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              listData.applicantName != null
                                                  ? listData.applicantName!
                                                  : "Null",
                                              style: TextStyle(
                                                  color: appColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                          Text(
                                            listData.region != null
                                                ? listData.region!
                                                : "Null",
                                            style: TextStyle(color: appColor),
                                          ),
                                          Text(
                                            listData.type != null
                                                ? listData.type!
                                                : "",
                                            style: TextStyle(color: appColor),
                                          ),
                                          Text(
                                            listData.applicantContact != null
                                                ? listData.applicantContact!
                                                : "Null",
                                            style: TextStyle(color: appColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: appColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      });
                }
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: appColor,
                ));
              }
            },
          ),
        ));
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> refreashData() async {
    // setState(() {});
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: UserData(userName: widget.userName, userId: widget.userId)));
  }
}
