import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udharproject/Activity/AddStaffFormPage.dart';
import 'package:permission_handler/permission_handler.dart';
class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}
class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contactsgfgfghgf = [];
  bool isLoading = true;
   PermissionStatus? _cameraStatus;
  @override
  void initState() {
    super.initState();
    _requestCameraPermission();

  }
  @override
  void dispose() {
    super.dispose();
  }
   List<Item?> phones = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Row(children: [
            Text("Contact List")
          ])
      ),
      body: contactsgfgfghgf.length>1 ? ListView.builder(
        itemCount: contactsgfgfghgf.length,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = contactsgfgfghgf[index];
          return ListTile(
            onTap: () async{
          String? disname=contact.givenName;
          String phoneNumber = contact.phones?.first?.value ?? '';
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffFormPage(phoneNumber,disname)),);
          }, contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
             leading: (contact.avatar != null && contact.avatar!.isNotEmpty) ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!),) : CircleAvatar(child: Text(contact.initials()),
               backgroundColor: Theme.of(context).canvasColor,),
            title: Text(contact.displayName ?? ''),

          );
        },
      ) : Center(child: const CircularProgressIndicator()),
    );
  }

void checkprermissionData() async{


  if (_cameraStatus!.isGranted) {
    // User granted permission to access the contact list
    fetchContacts();
  } else {
    // User denied permission to access the contact list
    Fluttertoast.showToast(
        msg: " Permission Denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  }


  void fetchContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      contactsgfgfghgf = contacts.toList();
      print(contacts);
    });

    // setState(() {
    //   isLoading = false;
    // });
  }

  void _requestCameraPermission() async{
   // _cameraStatus = await Permission.storage.request();
     _cameraStatus = await Permission.contacts.request();
    setState(() {
      checkprermissionData();
    });
  }
  Widget _buildContactList() {
    if (_cameraStatus!.isGranted && contactsgfgfghgf != null) {
      return ListView.builder(
        itemCount: contactsgfgfghgf.length,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = contactsgfgfghgf.elementAt(index);
          return ListTile(
            onTap: () async{
              String? disname=contact.givenName;
              String phoneNumber = contact.phones?.first?.value ?? '';
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddStaffFormPage(phoneNumber,disname)),);
            }, contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            leading: (contact.avatar != null && contact.avatar!.isNotEmpty) ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!),) : CircleAvatar(child: Text(contact.initials()),
              backgroundColor: Theme.of(context).canvasColor,),
            title: Text(contact.displayName ?? ''),

          );
        },
      );
    } else if (_cameraStatus!.isDenied || _cameraStatus!.isPermanentlyDenied) {
      return Center(
        child: Text('Permission to read contacts was denied'),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
