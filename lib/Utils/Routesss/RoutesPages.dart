import 'package:flutter/material.dart';
import 'package:udharproject/Activity/AdharCardOrPancardPage.dart';
import 'package:udharproject/Activity/AttendancePendingOrApproval/ApprovalAttendanceActivity.dart';
import 'package:udharproject/Activity/BusinessDetailsPage.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AddPaymentPageActvity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/AttendanceByPaticularStaff.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/SalarySlipShareActivity.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/StaffBankAccountDetailsPage.dart';
import 'package:udharproject/Activity/ContactListPage.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Activity/ForgetPasswordPage.dart';
import 'package:udharproject/Activity/HelpActivity/HelpActivityPage.dart';
import 'package:udharproject/Activity/LanguagePageActivity/LauagePageActivity.dart';
import 'package:udharproject/Activity/LoginPage.dart';
import 'package:udharproject/Activity/OtpVerificationPage.dart';
import 'package:udharproject/Activity/Registration.dart';
import 'package:udharproject/Activity/SplashScreen.dart';
import 'package:udharproject/Activity/StaffActivityData/MonthClosingBalancePageActivity.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffAttendanceActivityPage.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffDashbroadActvity.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffSalaryDeductionActivity.dart';
import 'package:udharproject/Activity/StaffActivityData/StaffWeeklyHolidaysActivity.dart';
import 'package:udharproject/Activity/StaffBonusAndAllowance/StaffBonusAndAllowanceActivity.dart';
import 'package:udharproject/Activity/StaffBonusAndAllowance/StaffShowBonusAndAllowanceActvity.dart';
import 'package:udharproject/Activity/StaffLeave/AddStaffLeaveActivity.dart';
import 'package:udharproject/Activity/StaffLeave/StaffApplyLeaveActvity.dart';
import 'package:udharproject/Activity/UpdateBusinessManDetails/BusinessNameUpdateActivity.dart';
import 'package:udharproject/Activity/WelcomeShivaBothLoginPage.dart';


import 'package:udharproject/Utils/Routesss/RoutesName.dart';

class RoutesPages{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesNamess.splashscreen:
        return MaterialPageRoute(builder: (context)=>SplashScreen());
      case RoutesNamess.loginscreen:
        return MaterialPageRoute(builder: (context)=>LoginPage());
      case RoutesNamess.registration:
        return MaterialPageRoute(builder: (context)=>Registation());
      case RoutesNamess.businessmandashboard:
        return MaterialPageRoute(builder: (context)=>DashBoard());
      case RoutesNamess.staffdashboard:
        return MaterialPageRoute(builder: (context)=>StaffDashBoardActivity());
        case RoutesNamess.forgetpassword:
        return MaterialPageRoute(builder: (context)=>ForgetPassword());
        case RoutesNamess.otpValidation:
        return MaterialPageRoute(builder: (context)=>OtpVerificationPage(settings.arguments as Map));
      case RoutesNamess.businessDetails:
        return MaterialPageRoute(builder: (context)=>BusinessDetails(settings.arguments as Map));
         case RoutesNamess.bussinessandstaffbothlogin:
        return MaterialPageRoute(builder: (context)=>BothLoginPage(settings.arguments as Map));
        case RoutesNamess.attendenceMonthwisebysaff:
        return MaterialPageRoute(builder: (context)=>AttendanceByParticularStaff(settings.arguments as Map));
       case RoutesNamess.contactpage:
        return MaterialPageRoute(builder: (context)=>ContactListPage());
        case RoutesNamess.helppage:
        return MaterialPageRoute(builder: (context)=>HelpActivityPage());
      case RoutesNamess.updapBusinessNamepage:
        return MaterialPageRoute(builder: (context)=>BusinessNameUpdateClassPage());
        case RoutesNamess.documentsBusinessManpage:
        return MaterialPageRoute(builder: (context)=>AdharCardORPanCardPage());
        case RoutesNamess.languagePage:
        return MaterialPageRoute(builder: (context)=>LanguageChangePage());
        case RoutesNamess.staffWeeklyHolidayPage:
        return MaterialPageRoute(builder: (context)=>StaffWeeklyHoliday(data: settings.arguments as Map));
        case RoutesNamess.salaryDeduction:
        return MaterialPageRoute(builder: (context)=> StaffSalryDeductionActivity(settings.arguments as Map));
        case RoutesNamess.staffShowbonuspage:
        return MaterialPageRoute(builder: (context)=> StaffShowBonusAndAllowanceActvity(settings.arguments as Map));
        case RoutesNamess.staffAddbonuspage:
          return MaterialPageRoute(builder: (context)=> StaffAddBonusAndAllowanceActivity(settings.arguments as Map));
        case RoutesNamess.staffattendacepage:
        return MaterialPageRoute(builder: (context)=> StaffAttendaceActivity());
        case RoutesNamess.approvalAttendance:
          return MaterialPageRoute(builder: (context)=> ApprovalAttendaceActivity());
          case RoutesNamess.salarySlip:
        return MaterialPageRoute(builder: (context)=> SalarySlip());
        case RoutesNamess.monthclosingBalance:
        return MaterialPageRoute(builder: (context)=> MonthClosingBalancyPage());
        case RoutesNamess.staffBankAccountDetails:
        return MaterialPageRoute(builder: (context)=> StaffBankAccountDetailsPage());
        case RoutesNamess.staffAddLeave:
        return MaterialPageRoute(builder: (context)=> AddStaffLeaveCatPage(settings.arguments as Map));
        case RoutesNamess.staffPayment:
        return MaterialPageRoute(builder: (context)=> AddPaymentActivityPage(settings.arguments as Map));
        case RoutesNamess.staffAssignLeave:
        return MaterialPageRoute(builder: (context)=> StaffApplyLeaveActivity(settings.arguments as Map));

        default: return MaterialPageRoute(builder: (context){
        return Scaffold(
          body: Center(child: Text("No route defined")),
        );
      });
    }
  }
}