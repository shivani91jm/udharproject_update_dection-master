class Urls{
  Urls._();
  static const String BaseUrls="https://crm.shivagroupind.com/api/";
  static const String loginApi=Urls.BaseUrls+'check-user-in-db';
  static const String RegistrationApi=Urls.BaseUrls+'register';
  static const String VerifyOtpApi=Urls.BaseUrls+'user-otp-verfiy';
  static const String AddStaff=Urls.BaseUrls+"add-staff";
  // -------------------second time bussiness man create-------------
  static const String AddBussiness=Urls.BaseUrls+"add-business";
  static const String BussinessList =Urls.BaseUrls+"fetch-bussniess-list";
  static const String FetchStaffList =Urls.BaseUrls+"fetch-staff-list";

  static const String BussinessInfo =Urls.BaseUrls+"get_document_upload_info";
  static const String MutipleStaffLoginUrl =Urls.BaseUrls+"fetch-staff-wise-list";
  static const String SocialMediaLoginUrl =Urls.BaseUrls+"social-media-check-user-db";
  static const String SocialMediaRegistrationUrl =Urls.BaseUrls+"social-media-register";
  static const String SocialMediaVerifyUser =Urls.BaseUrls+"social-media-user-verify";
  static const String UpdateMobileNumber =Urls.BaseUrls+"update-mobile-no";
  static const String BusinessDetailsNullValue =Urls.BaseUrls+"update-business-details";
  static const String BusinessDetailsDelete =Urls.BaseUrls+"delete-business-details";
  static const String MothlyWiseStaffList =Urls.BaseUrls+"get-staff-besiness-wise";
  //================== update staff details============================================
  static const String UpdateStaffDetails =Urls.BaseUrls+"staff-update-details";

  static const String GEtSTATEAPI =Urls.BaseUrls+"get-state";
  // upload profile staff and other data
  static const String UpdateStaffProfileDocs =Urls.BaseUrls+"upload-docs";
  // ------------------getUrstaff details----------------------------
  static const String GetStaffDeails= Urls.BaseUrls+"get-staff-details/";
  // -----------------------get subscrition api---------------------------
  static const String SubscriptionListAPi= Urls.BaseUrls+"get-subscription-data";
  static const String StaffAttendanceApi= Urls.BaseUrls+"staff-attendance";
  //----------------- add staff payment api -----------------------------
  static const String AddPaymentStaff= Urls.BaseUrls+"add-staff-payment";
  // ---------------attendance list monthly wise----------------------
  static const String AttendaceStaffMothlyList =Urls.BaseUrls+"staff-attendance-date-wise";
  //---------------aatendance list day wise home api-----------------------------------------------
  static const String AttenceListStaffDayList= Urls.BaseUrls+"get-staff-attendance-date-wise";
//------------------------------employee information api---------------------------------
  static const String StaffDayListDelinaton=Urls.BaseUrls+"add-staff-working-details";
  //---------------------------add over time rate api --------------------------------------
  static const String OverTimeRate=Urls.BaseUrls+"add-overtime-rate";

  //--------------------------over time rate fetch data --------------------
  static  const String fetchOverTimeRate=Urls.BaseUrls+"add-fetch-overtime-rate";

  //-------------------------delete over time rate api----------------------
  static const String deleteOverTimeRate=Urls.BaseUrls+"delete-overtime-rate";

  //--------------------add note ---------------------
  static const String addnoteapi=Urls.BaseUrls+"add-staff-note";
  //--------------------------delete note api --------------------------------------------------
  static const String deletenoteapi=Urls.BaseUrls+"delete-staff-note/";
  //------------------------------- fetch attendace history api-------------------------------------
  static const String fetchAttendanceHistory=Urls.BaseUrls+"get-attendance-activity/";

  //---------------------------------------delete staff api -------------------------
  static const String deleteStaff=Urls.BaseUrls+"delete-staff/";

  //-------------------------add department api-----------------------------------------
  static const String addDepartment=Urls.BaseUrls+"add-department";

  //-----------------------------------show department list api -----------------------------------
  static const String showDepartment=Urls.BaseUrls+"get-department/";

  //-----------------------update weekly holiday-------------------
  static const String updateWeeklyHoliday=Urls.BaseUrls+"update-staff-weekly-holidays";

  //--------------------------- new  add-shift (like morning or night ) ---------------------------------
  static const String addShiftTimeMorning=Urls.BaseUrls+"add-shift";

  //--------------------- delete shift ------------------------------------
  static const String deleteShiftTimeMorning=Urls.BaseUrls+"delete-shift/";

  //------------------ show shift list ---------------------------------
  static const String manageShiftTimeMorning=Urls.BaseUrls+"manage-shift/";

  //------------------ staff salary deduction ---------------------------------
  static const String staffSalryDeduction=Urls.BaseUrls+"staff-salary-deduction";

  //----------------- staff total month join -----------------------------------
  static const String getStaffJoinMonth=Urls.BaseUrls+"get-staff-attendance-month-wise";
  //------------add bonous---------------------------------------------------
  static const String addBonus=Urls.BaseUrls+"allowance-or-bonus";
  //------------add bonous---------------------------------------------------
  static const String staffshowBonus=Urls.BaseUrls+"show-allowance-or-bonus";
  //------------delete bonous---------------------------------------------------
  static const String staffDeleteBonus=Urls.BaseUrls+"delete-staff-bonus-or-allowance";

   //------------staff attendance approved---------------------------------------------------
  static const String staffAttendanceAproved=Urls.BaseUrls+"staff-attedance-approved";

 //------------staff delete  bonus or allowance ---------------------------------------------------
  static const String staffAttendanceDelete=Urls.BaseUrls+"delete-staff-bonus-or-allowance";
  //------------staff salary calculation  manual ---------------------------------------------------
  static const String staffSalaryCalculation = Urls.BaseUrls+"menual-staff-salary-calculation";

  //====================== salary add-previous-record =====================================
  static const String staffADDSalaryCalculatioPrevious = Urls.BaseUrls+"add-previous-record";
  static const String staffShowLeave = Urls.BaseUrls+"show-leave-category";
  static const String staffDeleteLeave = Urls.BaseUrls+"delete-leave-category";
  static const String staffRequestLeave = Urls.BaseUrls+"staff-leave-request";
  static const String staffAddLeave =    Urls.BaseUrls+"add-leave-categroy";
  static const String staffSalrySlipDownload =    Urls.BaseUrls+"download-salary-slip";


  // ===============================image urls documents=====================================
  static const String ImageUrls="https://crm.shivagroupind.com/img/document-info/";
  static const String AttendanceUrls="https://crm.shivagroupind.com/admin/assets/attedance_iamge/";

}