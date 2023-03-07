
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

Map<String, FaIcon> bottomNavItems = const {
 'Home' : FaIcon(FontAwesomeIcons.house),
 'Markets' : FaIcon(FontAwesomeIcons.chartSimple),
 'Portfolios' : FaIcon(FontAwesomeIcons.dollarSign),
 'News' : FaIcon(FontAwesomeIcons.newspaper),
 'Me' : FaIcon(FontAwesomeIcons.person) 
};

final Map<dynamic, String> listItem = {
  const Icon(Icons.people_alt): 'Account',
  const Icon(Icons.feedback): 'Feedback',
  const Icon(Icons.share): 'Share this App',
  const FaIcon(FontAwesomeIcons.triangleExclamation): 'Disclaimers',
  const Icon(Icons.settings): 'Settings',
  const Icon(Icons.info): 'About',
  const FaIcon(FontAwesomeIcons.broom): 'Clear Cache'
};

Map<String, dynamic> homeCardItem = {
   'Trade' : Image.asset('assets/Web_19-15.jpg'),
   'Invest' : Image.asset('assets/investment.jpg'),
   'Savings' : Image.asset('assets/savings.jpg')
};

const Map<String, FaIcon> accountSectionItems = {
  "Bank Account": FaIcon(FontAwesomeIcons.buildingColumns),
  "Account Security": FaIcon(FontAwesomeIcons.lock),
  "Notifications": FaIcon(FontAwesomeIcons.bell),
  "Insert Payment Method": FaIcon(FontAwesomeIcons.creditCard),
  "E-Statement": FaIcon(FontAwesomeIcons.file),
  "Referral Code" : FaIcon(FontAwesomeIcons.gift)
};

const Map<String, FaIcon> applicationSectionItems = {
  "Cryptacademy" : FaIcon(FontAwesomeIcons.graduationCap),
  "Hide Nominal": FaIcon(FontAwesomeIcons.userLock),
  "Clean Cache": FaIcon(FontAwesomeIcons.broom),
  "Fingerprint Sensor": FaIcon(FontAwesomeIcons.fingerprint),
  "News Settings": FaIcon(FontAwesomeIcons.gear)
};



extension FormatDate on String {
  String todayDate(DateTime now) {
    var format = DateFormat.yMMMMd().format(now);
    return format;
  }

  String currentTime(DateTime now) {
    var formatTime = DateFormat('kk:mm').format(now);
    return formatTime;
  }

  String parseDate(String time) {
    DateTime parse = DateFormat("yyyy-mm-dd'T'HH:mm:ss.SSS.'Z'").parse(time);
    var input = DateTime.parse(parse.toString());
    var outputFormat = DateFormat('MM/hh/yyyy hh:mm a');
    var outputDate = outputFormat.format(input);
    return outputDate;
  }

  
}


extension FormatCase on String{
   String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
