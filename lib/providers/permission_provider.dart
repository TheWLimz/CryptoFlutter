import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyek_6/pages/home.dart';

class PermissionProvider{
  Future getStoragePermission(BuildContext context) async {
    var status = await Permission.storage.status;

     if (status.isGranted){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage()));
 
     } 
     else if(status.isLimited){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enable this feature on settings'),));
     } else{
         openAppSettings();
     }
  }
}