import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radium_tech/Global/global.dart';
import 'package:radium_tech/Model/ResidenceModel/get_image_data.dart';
import 'package:radium_tech/Utils/colors.dart';

import '../../Api/apiUrl.dart';

class PhotoGraphs extends StatefulWidget {
  final int surid;
  final String formFormate;
  const PhotoGraphs({Key? key, required this.surid, required this.formFormate})
      : super(key: key);

  @override
  _PhotoGraphsState createState() => _PhotoGraphsState();
}

class _PhotoGraphsState extends State<PhotoGraphs> {
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;
  File? imageFile5;
  File? imageFile6;
  File? imageFile7;
  File? imageFile8;
  File? imageFile9;

  var clickstatus = true;
  _getFromCamera1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera4() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile4 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery4() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile4 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera5() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile5 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery5() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile5 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera6() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile6 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery6() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile6 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera7() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile7 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery7() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile7 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera8() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile8 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery8() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile8 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera9() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile9 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery9() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile9 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<void> _showChoiceDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery1();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera1();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery2();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera2();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery3();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera3();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog4(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery4();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera4();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog5(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery5();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera5();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog6(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery6();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera6();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog7(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery7();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera7();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog8(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery8();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera8();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog9(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery9();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera9();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void waittoaddImage() async {
    buildShowDialog(context);

    await Future.delayed(const Duration(seconds: 3), () {
      if (success == 'true') {
        clickstatus = true;

        Fluttertoast.showToast(
            msg: "Successfully Add Image.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: appColor,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Loginn()));
      } else if (success == 'error') {
        clickstatus = true;

        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: appColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        waittoaddImage();
      }
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Pictures",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<ImageResponse>(
            future: Api.GetImagedata(widget.surid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 1.25,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 120,
                                  child: Text(
                                    'Image (1)',
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(70),
                                          child: imageFile1 != null
                                              ? Image.file(
                                                  imageFile1!,
                                                  fit: BoxFit.fill,
                                                )
                                              : (snapshot.data!.data![0]
                                                          .image1 ==
                                                      null)
                                                  ? Center(
                                                      child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      appColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: Center(
                                                              child: Text(
                                                                  "Choose Image"))))
                                                  : Image.network(
                                                      snapshot.data!.data![0]
                                                          .image1!,
                                                      fit: BoxFit.fill,
                                                    ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: appColor,
                                        child: InkWell(
                                          onTap: () {
                                            _showChoiceDialog1(context);
                                          },
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Api.Addimage(
                                      imageFile1, widget.surid, 'addimageone');
                                  waittoaddImage();
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appColor,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 120,
                                  child: Text(
                                    'Image (2)',
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(70),
                                          child: imageFile2 != null
                                              ? Image.file(
                                                  imageFile2!,
                                                  fit: BoxFit.fill,
                                                )
                                              : (snapshot.data!.data![0]
                                                          .image2 ==
                                                      null)
                                                  ? Center(
                                                      child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      appColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: Center(
                                                              child: Text(
                                                                  "Choose Image"))))
                                                  : Image.network(
                                                      snapshot.data!.data![0]
                                                          .image2!,
                                                      fit: BoxFit.fill,
                                                    ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: appColor,
                                        child: InkWell(
                                          onTap: () {
                                            _showChoiceDialog2(context);
                                          },
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Api.Addimage(
                                      imageFile2, widget.surid, 'addimagetwo');
                                  waittoaddImage();
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appColor,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 120,
                                  child: Text(
                                    'Image (3)',
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(70),
                                          child: imageFile3 != null
                                              ? Image.file(
                                                  imageFile3!,
                                                  fit: BoxFit.fill,
                                                )
                                              : (snapshot.data!.data![0]
                                                          .image3 ==
                                                      null)
                                                  ? Center(
                                                      child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      appColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: Center(
                                                              child: Text(
                                                                  "Choose Image"))))
                                                  : Image.network(
                                                      snapshot.data!.data![0]
                                                          .image3!,
                                                      fit: BoxFit.fill,
                                                    ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: appColor,
                                        child: InkWell(
                                          onTap: () {
                                            _showChoiceDialog3(context);
                                          },
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Api.Addimage(imageFile3, widget.surid,
                                      'addimagethree');
                                  waittoaddImage();
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appColor,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.formFormate == "1")
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (4)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile4 != null
                                                  ? Image.file(
                                                      imageFile4!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image4 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image4!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog4(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile4, widget.surid,
                                          'addimagefour');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (5)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile5 != null
                                                  ? Image.file(
                                                      imageFile5!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image5 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image5!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog5(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile5, widget.surid,
                                          'addimagefive');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (6)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile6 != null
                                                  ? Image.file(
                                                      imageFile6!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image6 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image6!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog6(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile6, widget.surid,
                                          'addimagesix');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (7)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile7 != null
                                                  ? Image.file(
                                                      imageFile7!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image7 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image7!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog7(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile7, widget.surid,
                                          'addimageseven');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (8)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile8 != null
                                                  ? Image.file(
                                                      imageFile8!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image8 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image8!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog8(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile8, widget.surid,
                                          'addimageeight');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 80,
                                      height: 120,
                                      child: Text(
                                        'Image (9)',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(70),
                                              child: imageFile9 != null
                                                  ? Image.file(
                                                      imageFile9!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : (snapshot.data!.data![0]
                                                              .image9 ==
                                                          null)
                                                      ? Center(
                                                          child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Choose Image"))))
                                                      : Image.network(
                                                          snapshot.data!
                                                              .data![0].image9!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: appColor,
                                            child: InkWell(
                                              onTap: () {
                                                _showChoiceDialog9(context);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Api.Addimage(imageFile9, widget.surid,
                                          'addimagenine');
                                      waittoaddImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
