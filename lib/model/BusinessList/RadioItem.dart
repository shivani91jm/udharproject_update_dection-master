import 'package:flutter/material.dart';
import 'package:udharproject/model/BusinessList/RadioModel.dart';
import 'package:udharproject/model/OtpModel/GetBusiness.dart';
class RadioItem extends StatelessWidget {
   List<GetBusiness>? _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item!.first.businessName.toString(),
                  style: new TextStyle(


                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),

          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item!.first.businessName.toString()),
          )
        ],
      ),
    );
  }
}