import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/SalarySlipController.dart';
import 'package:udharproject/Controller/StaffJoiningMonthController.dart';
import 'package:udharproject/Services/DirectoryPath.dart';
import 'package:udharproject/Services/check_permission.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';

import 'package:path/path.dart' as Path;
class SalarySlip extends StatefulWidget {
  const SalarySlip({Key? key}) : super(key: key);

  @override
  State<SalarySlip> createState() => _SalarySlipState();
}

class _SalarySlipState extends State<SalarySlip> {
  Object? selectedUser;
  var monthName = "";
  var _state = 0;
  var type = "staff";
  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  SalarySlipController controller = Get.put(SalarySlipController());
  StaffJoingMonthlyCpntroller controllerssss = Get.put(StaffJoingMonthlyCpntroller());
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  String fileUrl="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  late String filePath="";
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
    setState(() {
      fileName ="dummy.pdf";
      print("filename"+fileName);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    controllerssss.type_of_login.value = "staff";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppContents.SalarySlip.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  //----------------- salary slip  container-------------------

                  Row(
                    children: [
                      //--------------------------allowance --------------------------------------
                      Obx(() =>
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,
                                    color: Color.fromRGBO(143, 148, 251, .6),),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(1)),
                                ),

                                child: RadioListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(AppContents.fullSlip.tr,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0
                                        ),),

                                    ],
                                  ),
                                  value: "Full Slip",
                                  groupValue: controller.selected.value,
                                  onChanged: (value) =>
                                      controller.updateTypeValue(value),
                                )
                            ),
                          ),
                      ),
                      //------------------------bonus payment --------------------------
                      Obx(() =>
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,
                                    color: Color.fromRGBO(143, 148, 251, .6),),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(1)),
                                ),

                                child: RadioListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(AppContents.summarySlip.tr,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSize.fitlarge
                                          ),),

                                      ],
                                    ),
                                    value: "Summary Slip",
                                    groupValue: controller.selected.value,
                                    onChanged: (value) =>
                                        controller.updateTypeValue(value)
                                )),
                          ),),
                    ],
                  ),
                  //----------------------- month container ----------------------------
                  GestureDetector(
                    onTap: () {
                      _showBootomSheet(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black38,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(143, 148, 251, .1),
                                spreadRadius: 1)
                          ],
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 8.0, 15.0, 0),
                              child: Text("Month", style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal

                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 1.0, 15.0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("" + monthName, style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal
                                  ),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.arrow_drop_down,
                                        color: Colors.white,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //---------------submit   shared button---------------------------------
                  GestureDetector(
                    onTap:   ()
                    async{


                      fileExists && dowloading == false
                          ? openfile()
                          : startDownload();

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color.fromRGBO(143,
                            148, 251, .6)),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(AppContents.Share.tr, style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    progressString,
                  ),
                  /////////////--------------------dwonload  -----------

                  GestureDetector(
                    onTap: () async{


                      fileExists && dowloading == false
                          ? openfile()
                          : startDownload();

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [Color.fromRGBO(
                              143, 148, 251, .2), Color.fromRGBO(
                              143, 148, 251, .2)
                          ])),
                      child: new MaterialButton(
                        highlightElevation: 50,
                        child: setUpButtonChild(),
                        onPressed: () {},
                        elevation: 4.0,
                        minWidth: double.infinity,
                        height: 48.0,

                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bulidListBussinessMan(BuildContext context) {
    return Obx(() =>
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controllerssss.monthList!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RadioListTile(
                    value: controllerssss.monthList[index].month.toString(),
                    groupValue: selectedUser,
                    title: Text(
                        controllerssss.monthList[index].month.toString()),
                    onChanged: (val) {
                      print("Radio $val");
                      setState(() {
                        selectedUser = val;
                        monthName = "" + selectedUser.toString();
                      });
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaffScreenPage()),);
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1, color: Colors.grey,);
          },));
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(AppContents.downloadandopen.tr,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
        ),
      );
    } else if (_state == 1) {
      return Center(
        child: Container(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void _showBootomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Column(
            children: [
              //--------------------------business man list api data-----------------------------------------
              Expanded(child: _bulidListBussinessMan(context)),
            ],
          );
        });
  }


  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    print("vbvdbve"+storePath);
    filePath = '$storePath/$fileName';
    print("gdgfgghdfghgdf"+filePath);
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(fileUrl, filePath,
          onReceiveProgress: (count, total) {
        print(""+count.toString());
            setState(() {
              progress = (count / total);
              print("hsgdhh"+progress.toString());
            });
          }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    print("dbdnfdfnf"+fileExistCheck.toString());
    setState(() {
      fileExists = fileExistCheck;
    });
  }
  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }
}
