import 'package:get/get.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/MutipleLanguage/HindiContent.dart';

class MultipleLanguagePage extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      AppContents.email : AppContents.email,
      AppContents.login :  AppContents.login,
      AppContents.email_validation: AppContents.email_validation,
      'email_not_validate': 'Please enter a valid Email',
      'donotaccountsignup': "Don't have an account? Sign UP",
      AppContents.settings: AppContents.settings,
      AppContents.otpvertification : AppContents.otpvertification,
      AppContents.forgetemail : AppContents.forgetemail,
      AppContents.sendto: AppContents.sendto,
      AppContents.verfyOtp: AppContents.verfyOtp,
    },
    'hi_IN': {
      AppContents.email: hindiContent.email,
      AppContents.login: hindiContent.login,
      AppContents.email_validation: hindiContent.email_validation,
      AppContents.emailverifi: hindiContent.emailverifi,
      'email_not_validate':'कृपया एक मान्य ईमेल दर्ज करें',
      'donotaccountsignup': 'कोई खाता नहीं है? साइन अप करें',
      AppContents.settings: hindiContent.settings,
      AppContents.otpvertification : hindiContent.otpvertification,
      AppContents.sendto:hindiContent.sendto,
      AppContents.cancel:hindiContent.cancel,
      AppContents.continues:hindiContent.continues,
      AppContents.Multiple:hindiContent.Multiple,
      AppContents.addmutipletitle:hindiContent.addmutipletitle,
      AppContents.Attendance:hindiContent.Attendance,
      AppContents.forgetemail:hindiContent.forgetemail,
      AppContents.verfyOtp:hindiContent.verfyOtp,
      AppContents.Otpnotmatch:hindiContent.Otpnotmatch,
      AppContents.OtpEmpty:hindiContent.OtpEmpty,
      AppContents.Done:hindiContent.Done,
      AppContents.loginSucess:hindiContent.loginSucess,
      AppContents.otpSucess:hindiContent.otpSucess,
      AppContents.BusinessDeatils:hindiContent.BusinessDeatils,
      AppContents.ResentOTp:hindiContent.ResentOTp,
      AppContents.Skip:hindiContent.Skip,
      AppContents.businessName:hindiContent.businessName,
      AppContents.noofstaffemp:hindiContent.noofstaffemp,
      AppContents.noofstaff:hindiContent.noofstaff,
      AppContents.temsandcondition:hindiContent.temsandcondition,
      AppContents.byContaine:hindiContent.byContaine,
      AppContents.shifthours:hindiContent.shifthours,
      AppContents.noshifthours:hindiContent.noshifthours,
      AppContents.staffwork:hindiContent.staffwork,
      AppContents.howcalculatesalary:hindiContent.howcalculatesalary,
      AppContents.calendermonth:hindiContent.calendermonth,
      AppContents.calenderdetails:hindiContent.calenderdetails,
      AppContents.caleverymonth:hindiContent.caleverymonth,
      AppContents.excludeweeklyoffs:hindiContent.excludeweeklyoffs,
      AppContents.excludeweeklyoffsdetails:hindiContent.excludeweeklyoffsdetails,
      AppContents.edit:hindiContent.edit,
      AppContents.hrs:hindiContent.hrs,
      AppContents.mins:hindiContent.mins,
      AppContents.staff:hindiContent.staff,
      AppContents.ok:hindiContent.ok,
      AppContents.name:hindiContent.name,
      AppContents.KYB:hindiContent.KYB,
      AppContents.Help:hindiContent.Help,
      AppContents.addstaff:hindiContent.addstaff,
      AppContents.searchstaff:hindiContent.searchstaff,
      AppContents.Overtime:hindiContent.Overtime,
      AppContents.Fine:hindiContent.Fine,
      AppContents.paidLeave:hindiContent.paidLeave,
      AppContents.Present:hindiContent.Present,
      AppContents.Absent:hindiContent.Absent,
      AppContents.HalfDay:hindiContent.HalfDay,
      AppContents.staffDetails:hindiContent.staffDetails,
      AppContents.completeKYB:hindiContent.completeKYB,
      AppContents.activebusiness:hindiContent.activebusiness,
      AppContents.Businesses:hindiContent.Businesses,
      AppContents.Language:hindiContent.Language,
      AppContents.secuitypass:hindiContent.secuitypass,
      AppContents.updatemobile:hindiContent.updatemobile,
      AppContents.businessSetting:hindiContent.businessSetting,
      AppContents.MonthCalculation:hindiContent.MonthCalculation,
      AppContents.uploadbusiness:hindiContent.uploadbusiness,
      AppContents.createbusiness:hindiContent.createbusiness,
      AppContents.mobileloginsucess:hindiContent.mobileloginsucess,
      AppContents.mobileEmpty:hindiContent.mobileEmpty,
      AppContents.mobileRequredd:hindiContent.mobileRequredd,
      AppContents.mobiletendigit:hindiContent.mobiletendigit,
      AppContents.logout:hindiContent.logout,
      AppContents.phonenumber:hindiContent.phonenumber,
      AppContents.personalinfo:hindiContent.personalinfo,
      AppContents.accountSetting:hindiContent.accountSetting,
      AppContents.passwordnotactive:hindiContent.passwordnotactive,
      AppContents.logoutsucesstitle:hindiContent.logoutsucesstitle,
      AppContents.calmonthdata:hindiContent.calmonthdata,
      AppContents.businessnameEmpty:hindiContent.businessnameEmpty,
      AppContents.businessdata:hindiContent.businessdata,
      AppContents.addprivousmonth:hindiContent.businessprevious,
      AppContents.SalarySlip:hindiContent.SalarySlip,
      AppContents.addPayment:hindiContent.addPayment,
      AppContents.adavncesalry:hindiContent.adavncesalry,
      AppContents.notmarked:hindiContent.notmarked,
      AppContents.sendwhatsappsalry:hindiContent.sendwhatsappsalry,
      AppContents.autosalry:hindiContent.autosalry,
      AppContents.marksattendancetitle:hindiContent.marksattendancetitle,
      AppContents.dwonloadattendance:hindiContent.dwonloadattendance,
      AppContents.addovertimeandfime:hindiContent.addovertimeandfime,
      AppContents.addovertime:hindiContent.addovertime,
      AppContents.pl:hindiContent.pl,
      AppContents.ot:hindiContent.ot,
      AppContents.F:hindiContent.F,
      AppContents.shiftSeting:hindiContent.shiftSeting,
      AppContents.noshiiftaddSeting:hindiContent.noshiiftaddSeting,
      AppContents.attendanceSetting:hindiContent.attendanceSetting,
      AppContents.attendanceonholiday:hindiContent.attendanceonholiday,
      AppContents.autoattendaceRule:hindiContent.autoattendaceRule,
      AppContents.firstattendance:hindiContent.firstattendance,
      AppContents.businessBankAccount:hindiContent.businessBankAccount,
      AppContents.LOCATIONENABLEDISBALE:hindiContent.LOCATIONENABLEDISBALE,
      AppContents.mutiplesamephonenumber:hindiContent.mutiplesamephonenumber,
      AppContents.workeryastaff:hindiContent.workeryastaff,
      AppContents.checkattendanceandsalryrec:hindiContent.checkattendanceandsalryrec,
      AppContents.imabussinessman:hindiContent.imabussinessman,
      AppContents.salaryattendance:hindiContent.salaryattendance,
      AppContents.whoareyou:hindiContent.whoareyou,
      AppContents.welcometo:hindiContent.welcometo,
      AppContents.puchin:hindiContent.puchin,
      AppContents.puchOut:hindiContent.puchOut,
      AppContents.manageBusines:hindiContent.manageBusines,
      AppContents.addBusines:hindiContent.addBusines,
      AppContents.selectslarypayment:hindiContent.selectslarypayment,
      AppContents.Monthly:hindiContent.Monthly,
      AppContents.Daily:hindiContent.Daily,
      AppContents.Hourly:hindiContent.Hourly,
      AppContents.weeklyPayment:hindiContent.weeklyPayment,
      AppContents.perhourbasic:hindiContent.perhourbasic,
      AppContents.punchInandpayment:hindiContent.punchInandpayment,
      AppContents.dailyPayment:hindiContent.dailyPayment,
      AppContents.workbasis:hindiContent.workbasis,
      AppContents.Weekly:hindiContent.Weekly,
      AppContents.staffmobileety:hindiContent.staffmobileety,
      AppContents.staffmobile:hindiContent.staffmobile,
      AppContents.staffnameety:hindiContent.staffnameety,
      AppContents.staffname:hindiContent.staffname,
      AppContents.Delete:hindiContent.Delete,
      AppContents.databackup:hindiContent.databackup,
      AppContents.shivagroupree:hindiContent.shivagroupree,
      AppContents.dateofJoin:hindiContent.dateofJoin,
      AppContents.attendancedate:hindiContent.attendancedate,
      AppContents.addnewDepartment:hindiContent.addnewDepartment,
      AppContents.addDepartmentName:hindiContent.addDepartmentName,
      AppContents.createDept:hindiContent.createDept,
      AppContents.staffwillregulare:hindiContent.staffwillregulare,
      AppContents.workbasisPayment:hindiContent.workbasisPayment,
      AppContents.fixedsalrypayment:hindiContent.fixedsalrypayment,
      AppContents.enterBusinessBascDetals:hindiContent.enterBusinessBascDetals,
      // AppContents.manageBusines:hindiContent.manageBusines,
      // AppContents.addBusines:hindiContent.addBusines,
      // AppContents.selectslarypayment:hindiContent.selectslarypayment,
      // AppContents.Monthly:hindiContent.Monthly,
      // AppContents.Daily:hindiContent.Daily,
      // AppContents.Hourly:hindiContent.Hourly,
      // AppContents.puchin:hindiContent.puchin,
      // AppContents.puchOut:hindiContent.puchOut,
      // AppContents.manageBusines:hindiContent.manageBusines,
      // AppContents.addBusines:hindiContent.addBusines,
      // AppContents.selectslarypayment:hindiContent.selectslarypayment,
      // AppContents.Monthly:hindiContent.Monthly,
      // AppContents.Daily:hindiContent.Daily,
      // AppContents.Hourly:hindiContent.Hourly,
      // AppContents.puchin:hindiContent.puchin,
      // AppContents.puchOut:hindiContent.puchOut,
      // AppContents.manageBusines:hindiContent.manageBusines,
      // AppContents.addBusines:hindiContent.addBusines,
      // AppContents.selectslarypayment:hindiContent.selectslarypayment,
      // AppContents.Monthly:hindiContent.Monthly,
      // AppContents.Daily:hindiContent.Daily,
      // AppContents.Hourly:hindiContent.Hourly,
      // AppContents.puchin:hindiContent.puchin,
      // AppContents.puchOut:hindiContent.puchOut,
      // AppContents.manageBusines:hindiContent.manageBusines,
      // AppContents.addBusines:hindiContent.addBusines,
      // AppContents.selectslarypayment:hindiContent.selectslarypayment,
      // AppContents.Monthly:hindiContent.Monthly,
      // AppContents.Daily:hindiContent.Daily,
      // AppContents.Hourly:hindiContent.Hourly,
      //
      // AppContents.alldatalinkphonenumber:hindiContent.alldatalinkphonenumber,
      // AppContents.enterpassword:hindiContent.enterpassword,
      // AppContents.enterNote:hindiContent.enterNote,
      // AppContents.addNote:hindiContent.addNote,
      // AppContents.chooseChnage:hindiContent.chooseChnage,
      // AppContents.hindi:hindiContent.hindi,
      // AppContents.ProfileDetails:hindiContent.ProfileDetails,
      // AppContents.staffWeeklyHoli:hindiContent.staffWeeklyHoli,
      // AppContents.empInfo:hindiContent.empInfo,
      // AppContents.empID:hindiContent.empID,
      // AppContents.addStaffEnjoy:hindiContent.addStaffEnjoy,
      // AppContents.makeAttedanceDeduct:hindiContent.makeAttedanceDeduct,
      // AppContents.empEmpty:hindiContent.empEmpty,
      // AppContents.empDesignation:hindiContent.empDesignation,
      // AppContents.noofhours:hindiContent.noofhours,
      // AppContents.totaladvance:hindiContent.totaladvance,
      // AppContents.totaladavanceEntry:hindiContent.totaladavanceEntry,
      // AppContents.overtimelateline:hindiContent.overtimelateline,
      // AppContents.ourPromise:hindiContent.ourPromise,
      // AppContents.safefree:hindiContent.safefree,
















































    }
  };


}