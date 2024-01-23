import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/model/SubScritonModel/Info.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool _isLoading=false;
 List<Info>? info=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSubscriptionList();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Row(
              children: [
                Text("SubScription",style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),)
              ])
      ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
        {
          return   SingleChildScrollView(
            child: Column(
              children: [
                  Container(
                    child: _isLoading==false ? _ErrorWidget(): subscritionListShowWidget(),
                  )
              ],
            ),
          );
        })
    );
  }
  void showSubscriptionList() async{
    SharedPreferences prefsdf = await SharedPreferences.getInstance();
    var   token= prefsdf.getString("token").toString();
    var user_id = prefsdf.getString("user_id").toString();
    var bussiness_id=prefsdf.getString("bussiness_id").toString();
    var _futureLogin = BooksApi.SubscriptionListAPi(context,token);
    if (_futureLogin != null) {
      _futureLogin.then((value) {
        var res = value.response;

        if (res == "true") {
          if (value.info!= null) {
            info = value.info;
           setState(() {
             _isLoading=true;
           });

          }
        }

      });
    }
    else {
      _futureLogin.then((value) {
        String data = value.msg.toString();
        _isLoading=true;
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
  Widget subscritionListShowWidget()
  {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: info!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: (){},
          title:  Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                                image: NetworkImage("https://blogs.stromhrm.co.uk/wp-content/uploads/2020/08/facial-recognition-technologies.jpg",
                                ), fit: BoxFit.cover),

                          ),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(""+info![index].heading.toString(), style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),),
                          SizedBox(child: Text(""+info![index].desc.toString()),width: 250,),
                          Text(""+info![index].days.toString(), style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),),
                          Text(""+info![index].price.toString(), style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),)
                        ],
                      ),
                    )

                    ],
                  ),
                  ],
              ),
            ),
          ),
        );
      },

    );
  }
  Widget _ErrorWidget() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.deepPurpleAccent,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepPurple),
      ),
    );
  }
}
