import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/filteration_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/db_functions/username_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/screens/navigator.dart';
import 'package:money_manager/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkRegister(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TransactionDB.instance.refreshHome();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(0, 251, 251, 251),
              Color.fromARGB(255, 253, 254, 254)
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.35,
            ),
            const Image(
              image: AssetImage(
                  'lib/assets/image/flat-man-with-golden-coins-receive-cashback-e-wallet_88138-835.webp'),
              width: 480,
              height: 150,
            ),
            SizedBox(
              height: height * 0.1,
            ),
            const Text(
              'MONEY MAGNET',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(195, 3, 41, 59)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToGetPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const GetScreen()));
  }

  Future<void> checkRegister(BuildContext context) async {
    final sharePrefs = await SharedPreferences.getInstance();
    final userRegistered = sharePrefs.getBool(saveKeyValue);
    if (userRegistered == null || userRegistered == false) {
      goToGetPage();
    } else {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) {
        return;
      }
      UserNameDB.instance.getUserName();
      filterFunction();

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ScreenNavigator()));
    }
  }
}
