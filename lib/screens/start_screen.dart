import 'package:flutter/material.dart';
import 'package:money_manager/screens/welcome_screen.dart';

class GetScreen extends StatelessWidget {
  const GetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/assets/image/flat-man-with-golden-coins-receive-cashback-e-wallet_88138-835.webp'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 105, 128, 209),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => const ScreenWelcome()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Text(
                        'Get Start',
                        style: TextStyle(fontSize: 19, color: Colors.black),
                      ),
                    )),
              ),
              SizedBox(
                height: height * 0.04,
              )
            ],
          ),
        ),
      ),
    );
  }
}
