
import 'dart:io';
import 'package:flutter/material.dart';
Future<bool> showExitPopup(BuildContext context) async{
  return await showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Color.fromRGBO(143, 148, 251, .6),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                        'assets/images/exitimage.png',
                        width: 120,
                        height: 120,
                        fit:BoxFit.cover
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,20,20,20),
                  child: Center(child: Text("Do you want to exit?",style: TextStyle(
                    color: Color.fromRGBO(143, 148, 251, .6),
                    fontSize: 17,
                    fontWeight: FontWeight.w800
                  ),)),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: Text("Yes",style: TextStyle(
                            fontWeight: FontWeight.w800
                        ),),
                        style: ElevatedButton.styleFrom(
                            primary:   Color.fromRGBO(143, 148, 251, .6),),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child: Text("No", style: TextStyle(color: Colors.black,  fontWeight: FontWeight.w800)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,

                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
