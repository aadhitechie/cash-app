import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/db_functions/catagory_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/db_functions/username_db.dart';
import 'package:money_manager/screens/settings/about/about.dart';
import 'package:money_manager/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ScreenSettings extends StatefulWidget {
  const ScreenSettings({
    Key? key,
    //  required this.name, required this.index
  }) : super(key: key);

  // final String name;
  // int index;

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  late TextEditingController nameEditingController;
  late int userNameIndex;
  @override
  void initState() {
    // nameEditingController = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TransactionDB.instance.refresh();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.06,
              ),
              CustomCard(
                elevation: 0,
                width: width,
                height: height * 0.6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: height * 0.013),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.035,
                      ),
                      Container(
                        width: width * 0.82,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 10, 138, 218),
                                Color.fromARGB(255, 14, 135, 195)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const About(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((ctx) => const About())));
                                },
                                icon: const Icon(Icons.info_outline),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => const About(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'About',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      InkWell(
                        onTap: () {
                          showbottomsheeet(context: context);
                        },
                        child: Container(
                          width: width * 0.82,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 10, 138, 218),
                                  Color.fromARGB(255, 14, 135, 195)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent)),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showbottomsheeet(context: context);
                                },
                                icon: const Icon(Icons.mail_outline),
                              ),
                              TextButton(
                                onPressed: () {
                                  showbottomsheeet(context: context);
                                },
                                child: const Text(
                                  'Contact',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      Container(
                        width: width * 0.82,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 10, 138, 218),
                                Color.fromARGB(255, 14, 135, 195)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent)),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Share App',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      // Container(
                      //   width: width * 0.82,
                      //   decoration: BoxDecoration(
                      //       gradient: const LinearGradient(
                      //         begin: Alignment.centerLeft,
                      //         end: Alignment.centerRight,
                      //         colors: [
                      //           Color.fromARGB(255, 10, 138, 218),
                      //           Color.fromARGB(255, 14, 135, 195)
                      //         ],
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(color: Colors.transparent)),
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).push(
                      //         MaterialPageRoute(
                      //           builder: (ctx) => const About(),
                      //         ),
                      //       );
                      //     },
                      //     child: Row(
                      //       children: [
                      //         IconButton(
                      //           onPressed: () {
                      //             Navigator.of(context).push(MaterialPageRoute(
                      //                 builder: ((ctx) => const About())));
                      //           },
                      //           icon: const Icon(Icons.info_outline),
                      //         ),
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (ctx) => const About(),
                      //               ),
                      //             );
                      //           },
                      //           child: const Text(
                      //             'About',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: width * 0.82,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 10, 138, 218),
                                Color.fromARGB(255, 14, 135, 195)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent)),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                conformRestart(context);
                              },
                              icon: const Icon(Icons.restart_alt_outlined),
                            ),
                            TextButton(
                              onPressed: () {
                                conformRestart(context);
                              },
                              child: const Text(
                                'Restart App',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> conformRestart(BuildContext ctx) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text(
          "This will permanently delete the app's data including your transactions and preferences",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No')),
          TextButton(
              onPressed: () {
                restartApp(ctx);
              },
              child: const Text('Yes'))
        ],
      ),
    );
  }

  Future<void> restartApp(BuildContext context) async {
    TransactionDB.instance.restartTransaction();
    CategoryDB.instance.restratCategory();
    UserNameDB.instance.restratUserName();
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
    if (!mounted) {}
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const GetScreen()),
        (route) => false);
  }

  feedback() {
    String email = 'adarshadhu47167@gmail.com';
    String subject = 'Feed Back';
    String body = 'Type your feed back here: ';

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(
          <String, String>{'subject': subject, 'body': body}),
    );
    launchUrl(emailUri);
  }

  showbottomsheeet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.213,
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              // gradient: colorsobj.colorslight(),
              // color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://www.linkedin.com/in/adarsh-m-075735208');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'lib/assets/image/3536569.png',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'LinkedIn',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://www.instagram.com/adxrshm/?igshid=YmMyMTA2M2Y%3D');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'lib/assets/image/1400829.png',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'Instagram',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
