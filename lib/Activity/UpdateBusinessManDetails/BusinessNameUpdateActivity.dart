import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/UpdateBusniessNameController.dart';
import 'package:udharproject/Utils/AppContent.dart';

class BusinessNameUpdateClassPage extends StatefulWidget {
   BusinessNameUpdateClassPage({Key? key}) : super(key: key);

  @override
  State<BusinessNameUpdateClassPage> createState() => _BusinessNameUpdateClassPageState();
}

class _BusinessNameUpdateClassPageState extends State<BusinessNameUpdateClassPage> {
  BusinessNameController controller =Get.put(BusinessNameController());
  SharedPreferences? sharedPreferences;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Update Business Name",
          style: TextStyle(

        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Form(
                 key: _formkey,
                 child: Column(
               children: [
                     Container(
                       padding: const EdgeInsets.fromLTRB(8.0,30.0,8.0,0.0),
                       child: TextFormField(
                         keyboardType: TextInputType.text,
                         inputFormatters: <TextInputFormatter>[
                           new LengthLimitingTextInputFormatter(30)
                         ],
                         controller: controller.et_businessNameController,
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return AppContents.businessnameEmpty.tr;
                           }
                           return null;
                         },
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: AppContents.businessName.tr,
                             hintStyle: TextStyle(color: Colors.black54),
                             enabledBorder: OutlineInputBorder(
                               borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),
                             ),

                             focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromRGBO(143, 148, 251, 6)),)  ),
                       ),
                     ),

                     //----------------------- submit conatiner-----------------------------------
                     SizedBox(
                       height: 20,
                     ),
                     //-----------------------------submit btn...-------------------------------------------
                     Obx(() =>  GestureDetector(
                       onTap: () async {
                         if(_formkey.currentState!.validate())
                           {
                               controller.updateBusniessName(context);
                           }
                       },
                       child:   Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Align(
                           alignment: Alignment.bottomCenter,
                           child: Container(
                             height: 50,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 gradient: LinearGradient(
                                     colors: [
                                       AppColors.drakColorTheme,
                                       AppColors.lightColorTheme
                                     ])
                             ),
                             child: Center(
                               child: controller.isLoading.value?Center(child:
                               Container(height:20,width:20,
                                   child: CircularProgressIndicator(color: AppColors.white,))):
                               Text(AppContents.continues.tr,
                                 style: TextStyle(
                                   color: AppColors.white,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),))
                 ],
             )
             )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
