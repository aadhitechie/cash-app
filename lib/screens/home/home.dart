import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_functions/catagory_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/models/catagory_data_model.dart';
import 'package:money_manager/models/transaction_data_model.dart';
import 'package:money_manager/screens/navigator.dart';
import 'package:money_manager/screens/transaction/transaction_delete_popup.dart';

import '../../db_functions/filteration_db.dart';
import '../../db_functions/username_db.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    TransactionDB.instance.refreshHome();
    UserNameDB.instance.getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TransactionDB.instance.refreshHome();
    TransactionDB.instance.refresh();
    CategoryDB().refreshUI();
    UserNameDB.instance.getUserName();
    filterFunction();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          title: Text(
            UserNameDB.instance.userNameNotifier.value.username,
            style: const TextStyle(
              color: Color.fromARGB(255, 10, 10, 10),
              fontSize: 18,
            ),
          ),
          leadingWidth: 2000,
          backgroundColor: Colors.white30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.10,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.25,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 10, 138, 218),
                    Color.fromARGB(255, 14, 135, 195)
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.035,
                  ),
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Text(
                    totalBalance.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                totalIncome.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.arrow_downward_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                              Text(
                                totalExpense.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Recent Transaction',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (ctx) => const ScreenCategory()));
                  //   },
                  //   child: const Text(
                  //     'See all category',
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0,
            ),
            CustomCard(
              childPadding: 2,
              elevation: 0,
              color: Colors.transparent,
              width: width * 0.92,
              height: height * 0.45,
              borderRadius: 10,
              child: ValueListenableBuilder(
                valueListenable:
                    TransactionDB.instance.transactionhomeListNotifier,
                builder: (BuildContext ctx,
                    List<TransactionModel> transactionList, Widget? _) {
                  return TransactionDB
                          .instance.transactionhomeListNotifier.value.isEmpty
                      ? Stack(
                          children: [
                            Center(
                              child: Text(
                                'No Data Available',
                                style: GoogleFonts.anton(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemBuilder: (ctx, index) {
                            final data = transactionList[index];
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      onPressed: (ctx) {
                                        showTransactionDelete(context, data);
                                      },
                                      icon: Icons.delete,
                                      label: 'delete',
                                    )
                                  ]),
                              key: Key(data.id!),
                              child: CustomCard(
                                borderRadius: 10,
                                child: ListTile(
                                  leading: data.type == CategoryType.income
                                      ? const Icon(
                                          Icons.arrow_circle_up_outlined,
                                          color: Colors.black,
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.arrow_circle_down_outlined,
                                          color: Colors.black,
                                          size: 35,
                                        ),
                                  title: Text(data.catagory.name),
                                  subtitle: Text(
                                    data.type.name,
                                    style: TextStyle(
                                      color: data.type == CategoryType.income
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 14,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '₹ ${data.amount.toString()}',
                                          style: TextStyle(
                                            color:
                                                data.type == CategoryType.income
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0,
                                        ),
                                        Text(parseDate(data.date))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return SizedBox(
                              height: height * 0.01,
                            );
                          },
                          itemCount: transactionList.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
