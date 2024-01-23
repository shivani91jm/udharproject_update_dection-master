import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Contents/Urls.dart';

class StaffBankAccountDeatilsController extends GetxController{
  TextEditingController et_holderName = TextEditingController();
  TextEditingController et_accountNumer = TextEditingController();
  TextEditingController et_confirmAccountNumber= TextEditingController();
  TextEditingController et_ifsc_code = TextEditingController();
  TextEditingController et_upi_staff_id = TextEditingController();
  Rx<DateTime> selectedDatess = DateTime.now().obs;
  var selectedPaymentType = 'AccountTransfer'.obs;
  RxList<String>? monthList=['June','May'].obs;
  var mouth='June'.obs;
  RxBool paymenttypeflag=true.obs;
  RxBool isLoading=false.obs;
  RxInt state=0.obs;
  var isButtonEnabled = false.obs;
  BuildContext? context = Get.key.currentContext;
  final FormKey = GlobalKey<FormState>();
  void updatePaymentTypeValue(Object? value) {
    selectedPaymentType.value = value.toString();
    paymenttypeflag.value = !paymenttypeflag.value;
    print("paymentflag"+  paymenttypeflag.value.toString());
  }
  void listMonth(Object? value)
  {
    mouth.value=value.toString();
  }
  void statevisibilty()
  {
    state=1.obs;
  }
  void onTextFieldTap() {
    isButtonEnabled.value = true;
  }
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void onButtonPressed() {
    String text = et_holderName.text;
    staffBankAccountDetails();
    isButtonEnabled.value = false;
  }
  void staffBankAccountDetails() async{

    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
   var  bussiness_id=prefsdf.getString("bussiness_id").toString();
   var  staff_id=prefsdf.getString("staff_id").toString();
    var  staff_create_date= prefsdf.getString("staff_create_date").toString();
    var salary_type=prefsdf.getString("salary_payment_type").toString();
    var bank_account_no=et_accountNumer.text;
    var ifscode=et_ifsc_code.text;


    var furturedata= BooksApi.uploadDocument("", "",bank_account_no, ifscode, "", "", "", '',"", "", "", "", "","", staff_id,"","","", token, context!,et_holderName.text,"staff",et_upi_staff_id.text);
    if(furturedata!=null)
    {
      furturedata.then((value) {
        var res=  value.response;
        if(res=="true")
        {
          Fluttertoast.showToast(
              msg: "Document Uploaded Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          getBussinessInfomationApi();

        }
        else
        {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepPurpleAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    }
    }


  void getBussinessInfomationApi() async {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var _futureLogin = BooksApi.businessman(user_id, token, context!);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          var docs= value.info;
          // if(docs.bankName!=null)
          // {
          //   _BankAccountNOCOntroller.text=""+docs.bankName.toString();
          // }
          // else
          // {
          //   _BankAccountNOCOntroller.text="";
          // }
          if(docs!.accoundNumber!=null)
          {
            et_accountNumer.text=""+docs.accoundNumber.toString();
          }
          else
          {
            et_accountNumer.text="";
          }

          // if(docs.bankBranch!=null)
          // {
          //   _BankBranchController.text=""+docs.bankBranch.toString();
          // }
          // else
          // {
          //   _BankBranchController.text="";
          // }
          if(docs.bankIfsc!=null)
          {
            et_ifsc_code.text=""+docs.bankIfsc.toString();
          }
          else
          {
            et_ifsc_code.text="";
          }


          //setValueresponse();
        }
      });
    }
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    et_accountNumer.dispose();
    et_ifsc_code.dispose();
  }


}