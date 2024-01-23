import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/AddStaffLeaveController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
class AddStaffLeaveCatPage extends StatefulWidget {
  var data;
   AddStaffLeaveCatPage(this.data);

  @override
  State<AddStaffLeaveCatPage> createState() => _AddStaffLeaveCatPageState();
}

class _AddStaffLeaveCatPageState extends State<AddStaffLeaveCatPage> {
  AddStaffLeaveController controller=Get.put(AddStaffLeaveController());
  final _formkey = GlobalKey<FormState>();
  var page="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page=widget.data['page'];
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              if(page=="1")...
              {
                Text(AppContents.addLeave.tr),
              }
              else...{
              Text("Holidays")
              }
            ],
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        bottomNavigationBar: page=="1"?GestureDetector(
            onTap: (){
              showdialogLeaveName(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ])),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(AppContents.addLeaves.tr,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSize.medium,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),),
            )
        ):Text(""),
        body: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isLoading.value? Center(child: CircularProgressIndicator()): buildLeaveListData()
        ))
    );
  }

  Widget buildLeaveListData() {
    return Column(
      children: [
        Obx(() =>   Visibility(
          visible: controller.leaveFlag.value==false,
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppContents.nodata.tr,style: TextStyle(
                  color: AppColors.lightTextColorsBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.medium
              ),),
            ),
          ),),),
        Obx(() => ListView.builder(
          itemCount: controller.leaveList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.white, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: (){
                    deleteLeavedialog(controller.leaveList[index].id.toString());
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppContents.leaveNmae.tr,style: TextStyle(
                              color: AppColors.lightTextColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.medium
                          ),),
                          Text(controller.leaveList[index].name.toString(),style: TextStyle(
                              color: AppColors.textColorsBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.small
                          ),),
                        ],
                      ),

                      Obx(() => Switch(
                        value: bool.parse(controller.leaveList[index].status.toString()),
                        onChanged: (value) {
                          var cat_id = controller.leaveList[index].id.toString();
                          var name = controller.leaveList[index].name.toString();
                          controller.toggleSwitch(!bool.parse(controller.leaveList[index].status.toString()), name, cat_id);
                          print("cat_id: " + cat_id);
                        },
                      )
                      )
                    ],
                  ),
                ),
              ),
            );
          },

        )),
      ],
    );
  }
  void showdialogLeaveName(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Center(
            child: Text(AppContents.addNewLeave.tr,style: TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppContents.leaveNmae.tr+" :",style: TextStyle(
                      fontSize: 15,
                      color: Colors.red
                  ),),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,10),
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppContents.leaveNmae.tr;
                        }
                        return null;
                      },
                      controller: controller.et_leaveName,
                      autofocus: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                          labelText: AppContents.leaveNmae.tr,
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
                if(_formkey.currentState!.validate()) {
                  var name = controller.et_leaveName.text;

                  controller.addStaffLeaveCat(name, "false", "");
                  Navigator.pop(context, 'Cancel');
                }
              } ,
              child:  Text(AppContents.ok.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),),
            ),
          ],
        ));
  }
  void deleteLeavedialog(String cat_id)
  {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text("Leave",style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),),
          content:  Text(AppContents.deleteLeave.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:  Text(AppContents.cancel.tr,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),),
            ),
            TextButton(
              onPressed: () async{
                controller.deleteStaffLeaveCat(cat_id);
                Navigator.pop(context, 'Cancel');
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
