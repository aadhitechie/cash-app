import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/username_db.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 220, 220),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 220, 220),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'A b o u t',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide.none,
                  ),
                  controller: tabController,
                  labelStyle: const TextStyle(fontSize: 18),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  tabs: const [
                    Tab(
                      text: 'App',
                    ),
                    Tab(
                      text: 'Developer',
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0163,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.grey,
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(255, 7, 53, 178),
                            Color.fromARGB(255, 59, 105, 255)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      height: height * 0.526,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView(
                              children: [
                                Text(
                                  'Hi ${UserNameDB.instance.userNameNotifier.value.username},\n\nwelcome to Money Magnet. Money magnet will help you take your budget, money and finance under control and won\'t take much time. you won\'t need to dig through your wallet or check your bank account to be aware of your financial circumstances. \n\n\n Thank you.',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: 0.5,
                                    wordSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Center(
                              child: Text(
                                'I am Adarsh M. Expertised in UI/UX Designing and Flutter development based on Kerala, If you have any queries related to money magnet or about me you can contact me by taping \'Contact Me\' on the settings.Once of all thank you for supporting me.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                const Text(
                  'version 1.0.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
