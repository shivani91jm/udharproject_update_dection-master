import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/EmloyeeDepartmentController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';

class EmploymentInformationPage extends StatefulWidget {
  var staff_id="",salary_payment_type="";
  EmploymentInformationPage(this.staff_id,this.salary_payment_type);
  @override
  State<EmploymentInformationPage> createState() => _EmploymentInformationPageState(this.staff_id,salary_payment_type);
}

class _EmploymentInformationPageState extends State<EmploymentInformationPage> {
  var staff_id="",salary_payment_type="";
  _EmploymentInformationPageState(this.staff_id,this.salary_payment_type);
  final _formkey = GlobalKey<FormState>();
  EmloyeeDepartmentController controller=Get.put(EmloyeeDepartmentController());
  var dropdwonOpen=false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppContents.empInfo.tr),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
            height: 30,
          ),
          //--------------------------- Employee ID container--------------------------------
          //_empIDcontroller container
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                new LengthLimitingTextInputFormatter(50)
              ],
              controller: controller.empIDcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppContents.empEmpty.tr;
                }
                return null;
              },
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  labelText: AppContents.empID.tr,
                  labelStyle: TextStyle(
                    color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  )  ),
            ),
          ),
          // date of joining conatiner
          //---------------------------dob container-------------------------------------------
        Obx(() =>   GestureDetector(
          onTap: (){
            controller.selectJoiningDateMthod(context);
          },
          child: Container(
            width: 350,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(border: Border.all(width: 1,
              color:   Color.fromRGBO(143, 148, 251, .6),),
                borderRadius: BorderRadius.all(Radius.circular(3))),
            padding: EdgeInsets.all(8.0),
            child:  Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.selectedDatess.value == null ? AppContents.dateofJoin.tr : '${DateFormat('dd/MM/yyyy').format(controller.selectedDatess.value)},',style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 6),fontSize: 14
                  ),),
                  Icon(Icons.calendar_month,color:  Color.fromRGBO(143, 148, 251, 6),)
                ],
              ),
            ),

          ),
        ),),
          //---------------------------designation container------------------------------------------
              customeAddDepatment(),
          // ---------------------department conatainer---------------------------------------------
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                new LengthLimitingTextInputFormatter(50)
              ],
              controller: controller.DepartmentController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Department is Requires!!';
                }
                return null;
              },
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  labelText: AppContents.empDesignation.tr,
                  labelStyle: TextStyle(
                      color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  )  )
            ),
          ),
          //----------------------- uan conatiner-----------------------------------------
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                new LengthLimitingTextInputFormatter(50)
              ],
              controller: controller.UANController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'UAN is Requires!!';
                }
                return null;
              },
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  labelText: 'Enter UAN Number',
                  labelStyle: TextStyle(
                      color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  )  )
            ),
          ),
          // ESI No . Conationer -----------------------------------
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                new LengthLimitingTextInputFormatter(50)
              ],
              controller: controller.ESINOController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'ESI Number is Requires!!';
                }
                return null;
              },
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  labelText: 'ESI Number',
                  labelStyle: TextStyle(
                      color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(color: AppColors.dartTextColorsBlack,fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: AppColors.textColorsBlack),

                  )  )
            ),
          ),

          //----------------------- submit conatiner-----------------------------------
          SizedBox(
            height: 20,
          ),
          //-----------------------------submit btn...-------------------------------------------
          Obx(() =>  GestureDetector(
            onTap: (){
              //controller.UpdateEmployeeDeatils(context,staff_id,this.salary_payment_type,_formkey);
              controller.ShowDeparmentMethod(context);
            },
            child:   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                      AppColors.dartTextColorsBlack,
                        AppColors.lightTextColorsBlack
                      ])),
                  child: Center(
                    child: controller.isLoading.value?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(color: Colors.white,))):Text("Continue",style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,

                    ),
                    ),
                  ),
                ),
              ),
            ),))
            ],
          ),
        ),
      ),
    );
  }
  //----------------------------------validation form ----------------------------------------------------------------------------------------
  void _validationData() async{
    //validation

  }
  //----------------------show daprtment list and add department ------------------------

  Widget customeAddDepatment(){
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //-------------custom drop dwon  --------
          InkWell(
            onTap: () async{
              controller.ShowDeparmentMethod(context);

              setState(() {
                dropdwonOpen=!dropdwonOpen;
              });
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
                      child: Text(controller.departmentName.value.toString(),style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.medium
                      ),),
                    ),
                    Icon(dropdwonOpen?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_outlined,color: AppColors.white,)
                  ],
                )
            ),
          ),
          if(dropdwonOpen)...
          {
            Column(children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.departmentLis!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                    var  id=controller.departmentLis![index].id.toString();
                    print("object"+id.toString());
                      dropdwonOpen=false;

                    },
                    title:  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("" + controller.departmentLis![index].departmentName.toString()),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 1,color: Colors.grey,);
                },

              ),
              GestureDetector(
                onTap: () async{
                  AddDepartmentDialog(context);
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
                    child: Text(AppContents.continues, style: TextStyle(
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
    );
  }
  //--------------------------------add department dialog box show -----------------------------4

  void AddDepartmentDialog(BuildContext context) {

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Center(
            child: Text(AppContents.addnewDepartment.tr,style: TextStyle(
                fontSize: AppSize.large,
                color: Colors.black87,
                fontWeight: FontWeight.bold
            ),),
          ),
          content: Container(
            height: 150,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(AppContents.mobileEmpty.tr),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,10),
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppContents.mobileloginsucess.tr;
                        }
                        return null;
                      },
                      controller: controller.DepartmentController,

                      autofocus: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                          labelText: AppContents.addDepartmentName.tr,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),

                          )  ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.toString().tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                controller.AddDeparmentMethod(context);
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
}
