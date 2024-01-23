import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Api/Debouncer.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';
class AllStaffListShowAndSearchStaff extends StatefulWidget {
  const AllStaffListShowAndSearchStaff({Key? key}) : super(key: key);

  @override
  State<AllStaffListShowAndSearchStaff> createState() => _AllStaffListShowAndSearchStaffState();
}

class _AllStaffListShowAndSearchStaffState extends State<AllStaffListShowAndSearchStaff> {
  List<GetStaffUser> getStaffList = [];
  List<GetStaffUser> userLists = [];
  final _debouncer = Debouncer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffListShow();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
      {
        return   Column(
          children: [
            buildSearch(),
            Expanded(child: _showStaffListLayout(context))
          ],
        );
      }
      ));
  }
  Widget _showStaffListLayout(BuildContext context){
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: getStaffList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(getStaffList[index].staffName!=null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0,15,15,15),
                child: Container(
                  margin:    EdgeInsets.fromLTRB(10.0,10,10,10),
                  child: Text(getStaffList[index].staffName.toString(),style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),),
                ),
              ),]
            else...[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0,15,15,15),
                child: Container(
                  margin:    EdgeInsets.fromLTRB(10.0,10,10,10),
                  child: Text("no data",style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),),
                ),
              ),
            ]
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1, color: Colors.grey,);
      },
    );
  }
  //---------------------------------- fetch api-----------------------
  void getStaffListShow() async
  {
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var _futureLogin = BooksApi.bussinessListData(user_id, token, context);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;
        if (res == "true") {
          if (value.info != null) {
            SocialInfo? info = value.info;
            print("ddgfhhshjhgfdhj"+info.toString());
            if(info!.getStaffUser!=null)
            {
                var getStaffLIstdata=info.getStaffUser;
                setState(()
                {
                    userLists=getStaffLIstdata!;
                    getStaffList=userLists;
                });
            }

          }
        }
      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
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

 Widget buildSearch() {
    return  //Search Bar to List of typed Subject
      Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: InkWell(
              child: Icon(Icons.search),
            ),
            contentPadding: EdgeInsets.all(15.0),
            hintText: 'Search ',
          ),
          onChanged: (string) {
            _debouncer.run(() {
              setState(() {
                getStaffList = userLists.where(
                      (u) => (u.staffName!.toLowerCase().contains(
                    string.toLowerCase(),
                  )),
                ).toList();
              });
            });
          },
        ),
      );
 }

 //---------------------------- add shift api ----------------------------------


}
