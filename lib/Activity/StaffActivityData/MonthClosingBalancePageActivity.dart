import 'package:flutter/material.dart';
class MonthClosingBalancyPage extends StatefulWidget {
  const MonthClosingBalancyPage({Key? key}) : super(key: key);

  @override
  State<MonthClosingBalancyPage> createState() => _MonthClosingBalancyPageState();
}

class _MonthClosingBalancyPageState extends State<MonthClosingBalancyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Apr Closing balance",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),

                ],
              ),

            ],
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),),
        body:  SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(border: Border.all(width: 1,
                  color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text('Hourly Salary',style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 10, 0),
                            child: Text('Rs.40,0000',style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(border: Border.all(width: 1,
                  color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text('Apr Salary',style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async{},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Rs 0',style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                             ],),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Earing  month amount
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Salary Breakup',style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                decoration: BoxDecoration(border: Border.all(width: 1,
                  color:   Color.fromRGBO(143, 148, 251, .6),),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Earnings',style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ],
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Rs 0',style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Deducations',style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ],
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Rs 0',style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //deducation conatiner


            ],
          ),
        ));
  }
}
