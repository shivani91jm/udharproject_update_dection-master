import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?>show(BuildContext ctx) async {
  if(Platform.isIOS)
  {
    return showCupertinoModalPopup<ImageSource>(
      context: ctx,
      builder: (ctx)=> CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text("Camera"),
            onPressed:() =>  Navigator.of(ctx).pop(ImageSource.camera)),
          CupertinoActionSheetAction(
              child: Text("Gallery"),
              onPressed:() =>  Navigator.of(ctx).pop(ImageSource.gallery)),
        ],
      ),
    );
  }
  else
  {
    return  showModalBottomSheet(isScrollControlled: true, elevation: 5, context: ctx,
        builder: (ctx) {
      return Container(
          decoration: new BoxDecoration(
          color: Colors.grey[100],
          borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0))),
          child:Padding(
                padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ListTile(
                title: const Text('Camera'),
                leading: Icon(Icons.camera_alt),
                  onTap: (){
                    Navigator.of(ctx).pop(ImageSource.camera);
                    }

                ),
          Divider(height: 1,),
          ListTile(title: const Text('Gallery'),
                leading: Icon(Icons.image),
            onTap: (){
              Navigator.of(ctx).pop(ImageSource.gallery);
             }
             ),],),)
      );
  });}

  }
