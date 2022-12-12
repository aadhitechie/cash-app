import 'package:flutter/material.dart';

import 'package:money_manager/screens/catetory/category_popup.dart';
import 'package:money_manager/screens/catetory/expense.dart';
import 'package:money_manager/screens/catetory/income.dart';

import '../../db_functions/catagory_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 220, 220),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.03),
              child: TabBar(
                  indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 10, 138, 218),
                      borderRadius: BorderRadius.circular(20)),
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicatorColor: const Color.fromARGB(255, 53, 227, 58),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: 'INCOME',
                    ),
                    Tab(
                      text: 'EXPENCE',
                    ),
                  ]),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                IncomeCategoryList(),
                ExpenceCatagoryList(),
              ]),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            FloatingActionButton(
              tooltip: 'Add',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromARGB(255, 10, 138, 218),
              onPressed: () {
                showCategoryAddPopup(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
