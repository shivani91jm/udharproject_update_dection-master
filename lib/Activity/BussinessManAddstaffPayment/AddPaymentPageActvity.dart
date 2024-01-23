import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BussinessManAddstaffPayment/CustomDialog.dart';
import 'package:udharproject/Activity/DashBoard.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffJoiningMonthController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/model/AddPaymentStaff/AddInfo.dart';

class AddPaymentActivityPage extends StatefulWidget {
  var data;
   AddPaymentActivityPage(this.data);
  @override
  State<AddPaymentActivityPage> createState() => _AddPaymentActivityPageState();
}

class _AddPaymentActivityPageState extends State<AddPaymentActivityPage> {
  var staff_name="",staff_id="";

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _Amountcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  Object? PaymentType;
  bool isChecked = false;
   Razorpay _razorpay = Razorpay();
   var staff_email="";
  var bussinessno="";
  bool btn_color_visiblity=false;
  bool online_btn_color_visiblity=false;
  bool isLoading=false;
  int _state=0;
  bool online_btn_click=true;
    StaffJoingMonthlyCpntroller controller= Get.put(StaffJoingMonthlyCpntroller());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    _razorpay.clear();
    _Amountcontroller.dispose();
    _descriptioncontroller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staff_id=widget.data['staff_id'];
    staff_email=widget.data['email'];
    staff_name=widget.data['staff_name'];
    bussinessno=widget.data['bussiness_mob'];
    initiateRazorPay();
    _Amountcontroller.addListener(() {
      final btn_color_visiblity= _Amountcontroller.text.isNotEmpty;
      setState(() {
        this.btn_color_visiblity=btn_color_visiblity;
        this.online_btn_color_visiblity=online_btn_color_visiblity;
      });

    });

  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_lVW2z7GEl4hget',
      'amount': ((int.parse(_Amountcontroller.text))*100).toString(),
      'name': staff_name,
      'description': 'Payment',
      'prefill': {'contact': bussinessno, 'email': staff_email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }
    void _handlePaymentSuccess(PaymentSuccessResponse response) {
            isLoading=true;
         addPaymentStaff(response.paymentId.toString(),((int.parse(_Amountcontroller.text))*100).toString(),"online","success");

    }

    void _handlePaymentError(PaymentFailureResponse response) {
      addPaymentStaff("",((int.parse(_Amountcontroller.text))*100).toString(),"online","unsuccess");
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      addPaymentStaff("",((int.parse(_Amountcontroller.text))*100).toString(),"wallet","success");
    }
    initiateRazorPay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }

    DateTime? _selectedDate=DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        selectableDayPredicate: (DateTime date) {
          // Disable current date and upcoming dates
          return date.isBefore(DateTime.now());
        }
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    controller.type_of_login.value="business_man";
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color.fromRGBO(143, 148, 251, .6);
      }
      return Color.fromRGBO(143, 148, 251, .6);
    }
    return  Scaffold(
      appBar: AppBar(
        title: Text(""+staff_name,style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold
        ),),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------------- you paid contaier and you took---------------------------------
                Row(
                    children: [
                      //----------------------you paid ------------------------
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          decoration: BoxDecoration(border: Border.all(width: 1,
                            color:   Color.fromRGBO(143, 148, 251, .6),),
                              borderRadius: BorderRadius.all(Radius.circular(3))),
                          child: RadioListTile(
                            title: Text(AppContents.youpaid.tr,style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              fontSize: 14,

                            ),),
                            value: "you_paid",
                            groupValue: PaymentType,
                            onChanged: (value){
                              setState(() {
                                PaymentType=value;
                                if(PaymentType=="you_paid")
                                {
                                  online_btn_click=true;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      //-------------you took ------------------------------------
                     Expanded(child:  Container(

                       margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                       decoration: BoxDecoration(border: Border.all(width: 1,
                         color:   Color.fromRGBO(143, 148, 251, .6),),
                           borderRadius: BorderRadius.all(Radius.circular(3))),
                       child: RadioListTile(
                         title: Text(AppContents.youtook.tr,style: TextStyle(
                           color: Color.fromRGBO(143, 148, 251, 1),
                           fontSize: 14,

                         ),),
                         value: "you_took",
                         groupValue: PaymentType,
                         onChanged: (value){
                           setState(() {
                             PaymentType=value;
                             if(PaymentType=="you_took")
                             {
                               online_btn_click=false;
                             }
                           });
                         },
                       ),
                     ),)
                    ]),
                //---------------------------amount container----------------------------------
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _Amountcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Amount is Requires!!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(50)
                    ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 16.0, 25.0, 16.0),
                        labelText: 'Enter Amount',
                        labelStyle: TextStyle(
                            color:  Color.fromRGBO(143, 148, 251, 1),

                        ),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),)  ),
                  ),
                ),
                //---------------------Date Conatiner----------------------------------
                //dob container

                GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: Container(
                    width: 350,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(border: Border.all(width: 1,
                      color:   Color.fromRGBO(143, 148, 251, .6),),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    padding: EdgeInsets.all(8.0),
                    child:  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_selectedDate == null ? 'Please Enter DOB' : '${DateFormat('dd/MM/yyyy').format(_selectedDate!)},',style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                          ),),
                          Icon(Icons.calendar_month,color:  Color.fromRGBO(143, 148, 251, 6),)
                        ],
                      ),
                    ),

                  ),
                ),
                //-----------------------salary  cycle container---------------------------
                Obx(() =>   Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(AppContents.salaryCycle.tr,style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            //-------------custom drop dwon  --------
                            Obx(() =>   InkWell(
                              onTap: (){

                                controller.checkDropDwon();
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.drakColorTheme,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(controller.selectedValue.toString(),style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSize.medium
                                        ),),
                                      ),
                                      Icon(controller.dropdwonOpen.value?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_outlined,color: AppColors.white,)
                                    ],
                                  )
                              ),
                            ),),
                            if(controller.dropdwonOpen.value)...
                            {
                              Column(children: [
                                Obx(() => ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller.monthList!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Obx(() => ListTile(
                                      onTap: (){
                                        controller.selectedValue!.value=controller.monthList![index].month.toString();
                                        controller.checkDropDwon();

                                      },
                                      title:  Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("" + controller.monthList![index].month.toString()),
                                            GestureDetector(
                                              onTap:(){
                                                var overtime_id=controller.monthList![index].month.toString();

                                              },
                                              child:  Container(
                                                child: Column(
                                                  children: [
                                                    Icon(Icons.cancel),
                                                  ],
                                                ),
                                              ),
                                            )


                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(height: 1,color: Colors.grey,);
                                  },

                                ),),
                                GestureDetector(
                                  onTap: () async{


                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 80, 20, 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          AppColors.drakColorTheme,
                                          AppColors.lightColorTheme
                                        ])),
                                    child: Center(
                                      child: Text(AppContents.continues.tr, style: TextStyle(
                                          color: AppColors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),

                              ],)
                            }
                          ],
                        ),
                      ),

                    ],
                  ),
                ),),



                // -----------------------description conatiner------------------------
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _descriptioncontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Description  is Requires!!';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      new LengthLimitingTextInputFormatter(50)
                    ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25.0, 16.0, 25.0, 16.0),
                        labelText: AppContents.description.tr,
                        labelStyle: TextStyle(
                            color:  Color.fromRGBO(143, 148, 251, .6)
                        ),
                        hintStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, .6)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),)  ),
                  ),
                ),
                // -------------------------send sms to staff---------------------------
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          subscritiionalertdialog(context);
                        },
                        child: Text(AppContents.sendsms.tr,style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                    ],
                  ),
                ),

                //------------conatiner term and condition-----------------------------------
                Container(
                  margin: EdgeInsets.fromLTRB(15,0,10,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppContents.byContaine.tr,style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      GestureDetector(
                        onTap: (){
                          subscritiionalertdialog(context);
                        },
                        child: Text(AppContents.temsandcondition.tr,style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                    ],
                  ),
                ),
                // ---------------------------Payment online------------
                GestureDetector(
                  onTap: () async{
                    if(online_btn_color_visiblity)
                    {
                      setState(() {
                        online_btn_color_visiblity=true;
                      });
                    }
                    openCheckout();
                  },
                  child: Visibility(
                    visible: online_btn_click,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: btn_color_visiblity?Color.fromRGBO(143, 148, 251, .6): Colors.black38,),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text('Pay Online',style: TextStyle(
                            color: btn_color_visiblity?Color.fromRGBO(143, 148, 251, 1): Colors.black38,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
                /////////////--------------------Save PPayment -----------
                GestureDetector(
                  onTap: (){
                    if(btn_color_visiblity)
                    {
                      setState(() {
                        btn_color_visiblity=true;
                      });
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: btn_color_visiblity?[
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ]: [Color.fromRGBO(143, 148, 251, .2), Color.fromRGBO(143, 148, 251, .2)] )),
                    child: new MaterialButton(
                      highlightElevation: 50,
                      child: setUpButtonChild(),
                      onPressed: btn_color_visiblity ? () {
                        setState(() {
                          if (_state == 0) {
                            btn_color_visiblity=true;
                            addPaymentStaff("null", _Amountcontroller.text, "cod", "success");
                          }
                        });
                      }: null,
                      elevation: 4.0,
                      minWidth: double.infinity,
                      height: 48.0,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void subscritiionalertdialog(BuildContext context)
  {

  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(AppContents.savePayment.tr,
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

  void addPaymentStaff(String payment_key,String amount,String pay_type,String status) async {
    setState(() {
      _state=1;
    });
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    var _selectedDatess=dateFormat.format(DateTime.parse(_selectedDate.toString()));
    print("date picker"+_selectedDatess.toString());
    var _futureLogin = BooksApi.AddPaymentStaff(context,token, staff_id,amount,pay_type,status,payment_key,_descriptioncontroller.text,_selectedDatess,PaymentType.toString(),controller.selectedValue.toString());
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info!= null) {
            isLoading=false;
            setState(() {
              _state=0;
            });
            List<AddInfo> ? info = value.info;
            showGeneralDialog(
              barrierDismissible: false,
              context: context,
              barrierColor: Colors.black54, // space around dialog
              transitionDuration: Duration(milliseconds: 800),
              transitionBuilder: (context, a1, a2, child) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                      parent: a1,
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.easeOutCubic),
                  child: CustomDialog( // our custom dialog
                    title: "Payment",
                    content: "Payment Successfully",
                    positiveBtnText: "Done",
                    negativeBtnText: "Cancel",
                    positiveBtnPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
                    },
                  ),
                );
              },
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return Text("gfhghf");
              },
            );
          }
        }
        else
        {
          setState(() {
            _state=0;
          });
          isLoading=false;
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
        isLoading=false;
        setState(() {
          _state=0;
        });
        Fluttertoast.showToast(
            msg: "" + data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }
}
