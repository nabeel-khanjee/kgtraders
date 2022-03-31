import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:radium_tech/Global/global.dart';
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

  List<WelcomeDetails>? tempList;

  List<WelcomeDetails>? Welcome_List1;
// void oasihd(){

// }

  @override
  initState() {
        Welcome_List.clear();
 
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

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        appBar: AppBar(
          title: Text(widget.userName),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image(image: AssetImage("assets/kg-logo.png"))),
              ListTile(
                style: ListTileStyle.drawer,
                leading: Icon(
                  Icons.person,
                  color: appColor,
                ),
                title: Text(
                  widget.userName,
                  style: TextStyle(color: appColor),
                ),
              ),
              ListTile(
                leading: Icon(
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
        body: Container(
             decoration: BoxDecoration(image: DecorationImage(
                fit: BoxFit.fitHeight,

                image: AssetImage(
                
                'assets/1.png'
                ))),

           
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: TextField(
                  // controller: searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: "Tasks",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: appColor))),
                  onChanged: (value) {
                    setState(() {
                      searchTasks(value);
                    });
                  },
                ),
              ),
              // Divider(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreashData,
                  child: FutureBuilder<Welcome>(
                    future: userListing,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (Welcome_List.isEmpty) {
                          return ListView(children: [
                            Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            0.5),
                                    child: const Text(
                                      "No Job Found",
                                    ),
                                  )
                                ]))
                          ]);
                        } else {
                          return searchController.text.isNotEmpty
                              ? orignalList()
                              : Welcome_List1 == null
                                  ? orignalList()
                                  : searchedList();
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
                ),
              ),
            ],
          ),
        ));
  }

  ListView searchedList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Welcome_List1!.length,
        itemBuilder: (context, index) {
          // var listData = Welcome_List[index];

          return Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                if (Welcome_List1![index].type == "Workplace") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: Welcome_List1![index].isHr!,
                          isSalarySlip: Welcome_List1![index].isSlip!,
                          formFormate: "1",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List1![index].surveyId!,
                        ),
                      ));
                } else if (Welcome_List1![index].type == "Residence") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "2",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List1![index].surveyId!,
                        ),
                      ));
                } else if (Welcome_List1![index].type == "Bank Statement") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "3",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List1![index].surveyId!,
                        ),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "4",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List1![index].surveyId!,
                        ),
                      ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  color: Colors.white.withOpacity(.8),
                  margin: EdgeInsets.only(top: 15),
                  shadowColor: appColor,
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(color: appColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        child: Image.network(
                          Welcome_List1![index].bankImg != null
                              ? Welcome_List1![index].bankImg!
                              : "http://radiumpk.com/wp-content/uploads/2019/09/radium-logo-2.png",
                          fit: BoxFit.contain,
                          width: 52,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                Welcome_List1![index].applicantName != null
                                    ? Welcome_List1![index].applicantName!
                                    : "Null",
                                style: TextStyle(
                                    color: appColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              Welcome_List1![index].region != null
                                  ? Welcome_List1![index].region!
                                  : "Null",
                              style: TextStyle(color: appColor),
                            ),
                            Text(
                              Welcome_List1![index].type != null
                                  ? Welcome_List1![index].type!
                                  : "",
                              style: TextStyle(color: appColor),
                            ),
                            Text(
                              Welcome_List1![index].applicantContact != null
                                  ? Welcome_List1![index].applicantContact!
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

  ListView orignalList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Welcome_List.length,
        itemBuilder: (context, index) {
          // var listData = Welcome_List[index];

          return Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                if (Welcome_List[index].type == "Workplace") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: Welcome_List[index].isHr!,
                          isSalarySlip: Welcome_List[index].isSlip!,
                          formFormate: "1",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List[index].surveyId!,
                        ),
                      ));
                } else if (Welcome_List[index].type == "Residence") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "2",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List[index].surveyId!,
                        ),
                      ));
                } else if (Welcome_List[index].type == "Bank Statement") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "3",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List[index].surveyId!,
                        ),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePageResidence(
                          isHrDetails: 0,
                          isSalarySlip: 0,
                          formFormate: "4",
                          userId: widget.userId,
                          userName: widget.userName,
                          surveyId: Welcome_List[index].surveyId!,
                        ),
                      ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  color: Colors.white.withOpacity(.8),
                  margin: EdgeInsets.only(top: 15),
                  shadowColor: appColor,
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(color: appColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        child: Image.network(
                          Welcome_List[index].bankImg != null
                              ? Welcome_List[index].bankImg!
                              : "http://radiumpk.com/wp-content/uploads/2019/09/radium-logo-2.png",
                          fit: BoxFit.contain,
                          width: 52,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                Welcome_List[index].applicantName != null
                                    ? Welcome_List[index].applicantName!
                                    : "Null",
                                style: TextStyle(
                                    color: appColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              Welcome_List[index].region != null
                                  ? Welcome_List[index].region!
                                  : "Null",
                              style: TextStyle(color: appColor),
                            ),
                            Text(
                              Welcome_List[index].type != null
                                  ? Welcome_List[index].type!
                                  : "",
                              style: TextStyle(color: appColor),
                            ),
                            Text(
                              Welcome_List[index].applicantContact != null
                                  ? Welcome_List[index].applicantContact!
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

  void searchTasks(String query) {
    tempList = Welcome_List;

    final search = Welcome_List.where((element) {
      final name = element.applicantName!.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() => Welcome_List1 = search);
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    localStorage.remove('user');
    localStorage.remove('token');
    token = null;
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
