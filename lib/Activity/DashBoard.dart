import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udharproject/Activity/AccountPage.dart';
import 'package:udharproject/Activity/AddStaffScreenPage.dart';
import 'package:udharproject/Activity/AttendancePageClass.dart';
import 'package:udharproject/Activity/ExitApplicationPage.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _page = 1;
  final screen = [
    AddStaffScreenPage(),
    AttendencePageClass(),
    AccountPage(),
  ];
final items =<Widget>[
  Padding(
    padding: const EdgeInsets.fromLTRB(0.0,20,5.0,5.0),
    child: Column(
      children: [
        Icon(Icons.people, size: 30),
        Text(AppContents.staff.tr,style: TextStyle(
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
                  color:AppColors.lightColorTheme,
                  buttonBackgroundColor: AppColors.lightColorTheme,
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
