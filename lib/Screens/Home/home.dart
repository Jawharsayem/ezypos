import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobile_pos/Screens/Home/home_screen.dart';
import 'package:mobile_pos/Screens/Report/reports.dart';
import 'package:mobile_pos/Screens/Settings/settings_screen.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import '../../constant.dart';
import '../Sales/sales_contact.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isNoInternet = false;

  static const List<Widget> _widgetOptions = <Widget>[HomeScreen(), SalesContact(), Reports(), SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void signOutAutoLogin() async {
    CurrentUserData currentUserData = CurrentUserData();
    if (await currentUserData.isSubUserEmailNotFound() && isSubUser) {
      await FirebaseAuth.instance.signOut();
      Future.delayed(const Duration(milliseconds: 5000), () async {
        EasyLoading.showError('User is deleted');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSubUser ? signOutAutoLogin() : null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to exit this app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), // Yes means pop
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false), // No means stay
                    child: const Text('No'),
                  ),
                ],
              ),
            ) ??
            false;

        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 6.0,
          selectedItemColor: kMainColor,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.home),
              label: lang.S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.shoppingCart),
              label: lang.S.of(context).sales,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.fileText),
              label: lang.S.of(context).reports,
            ),
            BottomNavigationBarItem(icon: const Icon(FeatherIcons.settings), label: lang.S.of(context).setting),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
