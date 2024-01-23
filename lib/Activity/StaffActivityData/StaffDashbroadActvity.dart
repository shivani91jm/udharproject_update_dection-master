import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/ExitApplicationPage.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffAccountPage.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffAttendanceListPage.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffPaymentsPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';

class StaffDashBoardActivity extends StatefulWidget {
  const StaffDashBoardActivity({Key? key}) : super(key: key);
  @override
  State<StaffDashBoardActivity> createState() => _StaffDashBoardActivityState();
}

class _StaffDashBoardActivityState extends State<StaffDashBoardActivity> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    int _page = 1;
    final screen =[
      StaffAttendanceListPage(),
      StaffPaymentsPage(),
      StaffAccountPage()
    ];
    final items =<Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0,20,5.0,5.0),
        child: Column(
            children: [
              Icon(Icons.people,size: 30),
              Text(""+AppContents.Attendance.tr,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.small,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),)
            ]
        ),
      ),
      Icon(Icons.co_present, size: 25,),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0,20,5.0,5.0),
        child: Column(
            children: [
              Icon(Icons.settings, size: 30),
              Text(AppContents.settings.tr,style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.small,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),)
            ]
        ),
      ),
    ];
    @override
    void initState() {
      super.initState();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    @override
    Widget build(BuildContext context)
    {
      return WillPopScope(
        onWillPop:() => showExitPopup(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  AppColors.lightColorTheme,
                  AppColors.drakColorTheme
                ]),),
          child: ClipRect(
            child: SafeArea(
              top: false,
              child: Scaffold(
                  extendBody: true,
                  bottomNavigationBar: Theme(data: Theme.of(context).copyWith(iconTheme: IconThemeData(
                      color: AppColors.white
                  )), child:  CurvedNavigationBar(
                    key: _bottomNavigationKey,
                    index: 1,
                    height: 60.0,
                    items: items,
                    color: Color.fromRGBO(143, 148, 251, 1),
                    buttonBackgroundColor: Color.fromRGBO(143, 148, 251, 1),
                    backgroundColor: Colors.transparent ,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 600),
                    onTap: (index) {
                      setState(() {
                        _page = index;
                      });
                    },
                    letIndexChange: (index) => true,
                  ),),
                  body: screen[_page]),
            ),
          ),
        ),
      );
    }
}
