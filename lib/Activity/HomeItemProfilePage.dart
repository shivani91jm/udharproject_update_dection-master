import 'package:flutter/material.dart';
import 'package:udharproject/Activity/PanCardPage.dart';
import 'package:udharproject/model/Book.dart';

class HomeItemProfilePage extends StatefulWidget {
  var amount="";
  var rating="";
  var url="";
  var username="";
  var email="testing";
  var status="panding";
  HomeItemProfilePage(this.url,this.username,this.rating,this.amount,this.email,this.status);
  @override
  State<HomeItemProfilePage> createState() => _HomeItemProfilePageState(this.url,this.username,this.rating,this.amount,this.email,this.status);
}

class _HomeItemProfilePageState extends State<HomeItemProfilePage> {
  var amount="";
  var rating="";
  var url="";
  var username="";
  var email="testing@gmail.com";
  var status="";
  _HomeItemProfilePageState(this.url,this.username,this.rating,this.amount,this.email,this.status);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: BackButton(

        ),
      ),
      body: Stack(
        alignment: Alignment.center,
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                   color:  Color.fromRGBO(143, 148, 251, 1),
                      child: Center(
                        child: Text(''),
                      ),
                    ),
                   ]
                ),
                Positioned(
                  top: 70,
              child:  Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green
              ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(url) ,
                ),
            ),
          ),
                Positioned(
                  top: 240,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text("$username",style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0

                              ),),
                              Text("$email",style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0

                              ),),
                            ],
                          ),
                        ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MaterialButton(
                            onPressed: (){},
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                 Row(
                                   children: [
                                     Text("$rating",style: TextStyle(
                                         color: Colors.green[500],
                                         fontStyle: FontStyle.normal,
                                         fontWeight: FontWeight.w800,
                                         fontSize: 14.0
                                     ),),
                                     Icon(Icons.star,color: Colors.red,size: 11,),
                                   ],
                                 ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Rating",style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0

                                  ),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 24.0,
                            child:   VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          MaterialButton(
                            onPressed: (){},
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("$amount",style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0

                                  ),),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Amount",style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0

                                  ),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 24.0,
                            child:   VerticalDivider(
                              color: Colors.black,

                            ),
                          ),
                          MaterialButton(
                            onPressed: (){},
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("5.0",style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0

                                  ),),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Total Year",style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0

                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                        Container(
                          height: 100,
                          child:   Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                       GestureDetector(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PanCardPage()),);
                    },
                    child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                    ])),
                    child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,20.0,20,20),
                    child: Text("ENQUIRY",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),),
                    ),),
                    )
                              ],
                            ),
                          ),
                        )

                      ],

                ))

              ],

      ),
    );
  }
}
