import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Controller/StaffShoBonusandAllowanceController.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
class StaffShowBonusAndAllowanceActvity extends StatefulWidget {
  var data;
   StaffShowBonusAndAllowanceActvity(this.data);
   @override
  State<StaffShowBonusAndAllowanceActvity> createState() => _StaffShowBonusAndAllowanceActvityState();
}

class _StaffShowBonusAndAllowanceActvityState extends State<StaffShowBonusAndAllowanceActvity> {
  var staffName="",staff_email="";
  final controller =Get.put(StaffShowBonusandAllowanceController());

  @override
  Widget build(BuildContext context) {
    staffName=widget.data['staff_name'].toString();
    controller.staff_id.value=widget.data['staff_id'].toString();
    staff_email=widget.data['staff_email'].toString();
    controller.showListAllowanceandBounus();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppContents.allowanceandbonus.tr,style: TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold
            ),),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(""+staffName,style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.small,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, RoutesNamess.staffAddbonuspage,arguments: {
              "staff_id":controller.staff_id.value,
              "staff_email":staff_email,

              "staff_flag":"false"
            });
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
                child: Text(AppContents.addallowanceandbonus.tr,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSize.medium,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ),),
          )
      ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {

        return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() =>  Container(
                child: controller.isLoading.value?
                Center(child: CircularProgressIndicator(
          backgroundColor: AppColors.lightColorTheme,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.lightColorTheme),
        ),
          ): HomePage(),
              ))
            ],
          ),

      );
    }));
  }
  Widget  HomePage() {
    return  Column(
      children: [
          //-----------------------------------show date change card------------------------------------------
        Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() =>  new IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: controller.previousBackEnable==true?AppColors.textColorsBlack: AppColors.disableIcon ),
                    onPressed:controller.previousBackEnable==true? () async {
                      controller.isLoading.value=true;
                      controller.getPreviousMonthData();

                    }: null,
                  ),),
                  Obx(() =>   Text(""+DateFormat('yyyy MMM').format(controller.currentDate.value), style: TextStyle(
                      color: AppColors.textColorsBlack,
                      fontSize: AppSize.medium,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold)
                  ),),
                  Obx(() =>  new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios,
                        color: controller.isButtonEnabled.value? AppColors.textColorsBlack :AppColors.disableIcon),
                    onPressed: controller.isButtonEnabled.value ? () async {
                      controller.isLoading.value=false;
                      controller.getCurrentMonthDataBack();
                    } : null,))
                ],
              ),
            ],
          ),
        ),
        //-------------------------total allowance andonus  card------------------------------------
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Row(
              children: [
                Container(
                  width: 92,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:BorderRadius.circular(5),
                    border: Border.all(
                      width:1,
                      color: AppColors.grey,
                      style: BorderStyle.solid,
                    ),),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppContents.total_allowance.tr,style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),),
                        Obx(() =>  Text(""+controller.totalallowance.value,style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 92,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:BorderRadius.circular(5),
                    border: Border.all(
                      width:1,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppContents.total_bonus.tr,style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),),
                        Obx(() =>  Text(""+controller.total_bonus.value,style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        //------------------show  allowance or bonus list ----------------------------------
        _buildMonthlyContrainer(),

      ],
    );
  }
  Widget _buildMonthlyContrainer() {
    return  Obx(() => ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.getBonusandAllowans.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () async{
            controller.isLoading=false.obs;
            Navigator.pushNamed(context, RoutesNamess.staffAddbonuspage,arguments: {
              "staff_id":controller.staff_id.value,
              "staff_email":staff_email,
              "staff_flag":"true"
            });
          },
          title:Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,13,10,8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Text(""+DateFormat('dd MMM yyyy').format(DateTime.parse(controller.getBonusandAllowans[index].createdAt.toString())),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Text(""+controller.getBonusandAllowans[index].type.toString()+":"+controller.getBonusandAllowans[index].desc.toString(),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                         ],
                  ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Text(""+DateFormat('dd MMM yyyy').format(DateTime.parse(controller.getBonusandAllowans[index].createdAt.toString())),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,8,10,2),
                            child: Text(""+controller.getBonusandAllowans[index].type.toString()+":"+controller.getBonusandAllowans[index].desc.toString(),style: TextStyle(
                                color: AppColors.textColorsBlack,
                                fontSize: AppSize.small,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ]
                )),
              ],
            ),
          ),

        );

      },
    ));
  }


}
