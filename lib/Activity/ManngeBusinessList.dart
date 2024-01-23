import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Activity/BusinessDetailsPage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Colors/ColorsClass.dart';
import 'package:udharproject/Utils/AppContent.dart';
import 'package:udharproject/Utils/Assets/Images/Images.dart';
import 'package:udharproject/Utils/FontSize/AppSize.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
import '../model/SocialMediaLogin/GetBussiness.dart';
class ManageBusinessList extends StatefulWidget {
  const ManageBusinessList({Key? key}) : super(key: key);
  @override
  State<ManageBusinessList> createState() => _ManageBusinessListState();
}

class _ManageBusinessListState extends State<ManageBusinessList> {
  List<GetBusiness> getBussiness=[];
  bool _isLoading=false;
  var user_id="";
  var bussiness_id="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bussinessListData();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(AppContents.manageBusines.tr),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            addBusiness();
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
                  child: Text(AppContents.addBusines.tr,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSize.medium,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),),
            )
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading==false? Center(child: CircularProgressIndicator()): _buildBussinessManListData()
        ));
  }
  void bussinessListData() async {
      SharedPreferences prefsdf = await SharedPreferences.getInstance();
      var   token= prefsdf.getString("token").toString();
        print("token"+token);
       user_id = prefsdf.getString("user_id").toString();
       bussiness_id=prefsdf.getString("bussiness_id").toString();

       print("userid"+user_id);
      var _futureLogin = BooksApi.bussinessListData(user_id, token, context);
          if (_futureLogin != null) {
            _futureLogin.then((value) {
              var res = value.response;
              if (res == "true") {
                _isLoading=true;
                if (value.info != null) {
                  SocialInfo? info = value.info;
                  print("ddgfhhshjhgfdhj"+info.toString());
                  if (info!.getBusiness != null) {
                    var getBussinessList = info.getBusiness;
                  setState(() {
                    getBussiness = getBussinessList!;
                    getBussiness.sort((a, b) => int.parse(bussiness_id).compareTo(a.id!));
                  });

                    var getlenghth= getBussiness.length;

                    print("dgsdhgshd"+getlenghth.toString());
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
                }
              }
              else if(res=="false")
                {
                  _isLoading=true;
                }
            });
          }
          else {
            _futureLogin.then((value) {
              String data = value.msg.toString();
              setState(() {
                _isLoading=true;
              });
              Fluttertoast.showToast(
                  msg: "" + data,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.drakColorTheme,
                  textColor: AppColors.white,
                  fontSize: AppSize.medium
              );
            });
          }
        }
        void addBusiness() async
        {
          Navigator.pushNamed(context, RoutesNamess.businessDetails,arguments: {
            "status":"false"
          });

        }
   Widget  _buildBussinessManListData(){
     return   ListView.builder(
        itemCount: getBussiness.length,
       itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(getBussiness[index].businessName!=null) ...[
                  Container(
                    child: ListTile(
                      title: Text(getBussiness[index].businessName.toString(),style: TextStyle(
                          color: AppColors.textColorsBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.medium
                      ),),
                      subtitle:  Text(getBussiness[index].businessName.toString(),style: TextStyle(
                          color: AppColors.lightTextColorsBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.small
                      ),),
                      leading:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagesAssets.acount1, height: 20,
                          width: 20,),
                      ),
                      trailing: getBussiness[index].id.toString()==bussiness_id?Container(
                        child: Column(
                          children: [],
                        ),
                      ):
                      GestureDetector(
                        onTap: () async {
                          deleteBusiness( getBussiness[index].id.toString(),context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 1, 10, 10),
                         decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         gradient: LinearGradient(colors: [
                                AppColors.drakColorTheme,
                             AppColors.lightTextColorsBlack
                           ])),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(AppContents.Delete.tr,style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.small
                            ),),
                          ),
                        ),
                      ),


                    ),
                  ),]
                else...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,15,15,15),
                    child: Container(
                      margin:    EdgeInsets.fromLTRB(10.0,10,10,10),
                      child: Text("no data",style: TextStyle(
                          color: AppColors.textColorsBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.medium
                      ),),
                    ),
                  ),
                ]
              ],
            ),
          );
        },

      );
    }
  void deleteBusiness(String business_id,BuildContext context) async{

    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var _futureLogin = BooksApi.deleteBussinessDetails(user_id,business_id,token,context);
    if (_futureLogin != null) {
      _futureLogin!.then((value) {
        var res = value.response.toString();
        if (res == "true") {
            setState(() {
              bussinessListData();
            });
        }

      });
    }
  }
}


