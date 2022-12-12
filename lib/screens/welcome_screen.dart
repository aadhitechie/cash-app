import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/filteration_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/db_functions/username_db.dart';
import 'package:money_manager/models/username_data_model.dart';
import 'package:money_manager/screens/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  final _formKey = GlobalKey<FormState>();

  final _fristNameController = TextEditingController();

  final _lastNameController = TextEditingController();
  @override
  void initState() {
    filterFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.15,
                  ),
                  const Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    UserNameDB.instance.userNameNotifier.value.username,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 213, 213, 213),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.033,
                  ),
                  const Text(
                    'Lets start our journey',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Image.asset(
                    'lib/assets/image/flat-relaxing-businessman-get-passive-income-from-stock-investing_88138-946.webp',
                    width: width * 0.8,
                    height: height * 0.3,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                    child: TextFormField(
                      controller: _fristNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User name should not be embty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Frist Name',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(195, 215, 230, 237),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Full name should not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Last name',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(195, 215, 230, 237),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 216, 223, 239),
                        minimumSize: Size(width * 0.92, height * 0.05),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkToRegistor(context);
                      } else {}
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> checkToRegistor(BuildContext context) async {
    final fristname = _fristNameController.text.trim();
    final lastname = _lastNameController.text.trim();
    if (fristname.isNotEmpty || lastname.isNotEmpty) {
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool(saveKeyValue, true);

      if (!mounted) {
        return;
      }
      final userModel = UserNameModel(
        username: lastname,
      );
      UserNameDB.instance.addName(userModel);
      UserNameDB.instance.getUserName();
      TransactionDB.instance.transactionhomeListNotifier;
      filterFunction();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ScreenNavigator()));
    } else {}
  }
}
