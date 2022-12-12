// ignore_for_file: invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/models/catagory_data_model.dart';
import 'package:money_manager/models/transaction_data_model.dart';
// import 'package:month_year_picker/month_year_picker.dart';

ValueNotifier<List<TransactionModel>> overviewNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> expenseNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> todayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> yesterdayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> incomeTodayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> incomeYesterdayNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModel>> expenseTodayNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> expenseYesterdayNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> lastWeekNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> incomeLastWeekNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModel>> expenseLastWeekNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModel>> lastMonthNotifier = ValueNotifier([]);

ValueNotifier<List<TransactionModel>> incomeLastMonthNotifier =
    ValueNotifier([]);

ValueNotifier<List<TransactionModel>> expenseLastMonthNotifier =
    ValueNotifier([]);

String today = DateFormat.yMd().format(
  DateTime.now(),
);
String yesterday = DateFormat.yMd().format(
  DateTime.now().subtract(
    const Duration(days: 1),
  ),
);

// ignore: duplicate_ignore
filterFunction() async {
  final list = await TransactionDB.instance.getAllTransaction();
  overviewNotifier.value.clear();
  incomeNotifier.value.clear();
  expenseNotifier.value.clear();
  todayNotifier.value.clear();
  yesterdayNotifier.value.clear();
  incomeTodayNotifier.value.clear();
  incomeYesterdayNotifier.value.clear();
  expenseTodayNotifier.value.clear();
  expenseYesterdayNotifier.value.clear();
  lastWeekNotifier.value.clear();
  expenseLastWeekNotifier.value.clear();
  incomeLastWeekNotifier.value.clear();
  lastMonthNotifier.value.clear();
  expenseLastMonthNotifier.value.clear();
  incomeLastMonthNotifier.value.clear();

  for (var element in list) {
    if (element.type == CategoryType.income) {
      incomeNotifier.value.add(element);
    } else if (element.type == CategoryType.expense) {
      expenseNotifier.value.add(element);
    }
    overviewNotifier.value.add(element);
  }

  for (var element in list) {
    String elementDate = DateFormat.yMd().format(element.date);
    if (elementDate == today) {
      todayNotifier.value.add(element);
    }

    if (elementDate == yesterday) {
      yesterdayNotifier.value.add(element);
    }
    if (element.date.isAfter(
      DateTime.now().subtract(
        const Duration(days: 7),
      ),
    )) {
      lastWeekNotifier.value.add(element);
    }

    if (element.date.isAfter(
      DateTime.now().subtract(
        const Duration(days: 30),
      ),
      // selectedGrapMonth
    )) {
      lastMonthNotifier.value.add(element);
    }

    if (elementDate == today && element.type == CategoryType.income) {
      incomeTodayNotifier.value.add(element);
    }

    if (elementDate == yesterday && element.type == CategoryType.income) {
      incomeYesterdayNotifier.value.add(element);
    }

    if (elementDate == today && element.type == CategoryType.expense) {
      expenseTodayNotifier.value.add(element);
    }

    if (elementDate == yesterday && element.type == CategoryType.expense) {
      expenseYesterdayNotifier.value.add(element);
    }
    if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ) &&
        element.type == CategoryType.income) {
      incomeLastWeekNotifier.value.add(element);
    }

    if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ) &&
        element.type == CategoryType.expense) {
      expenseLastWeekNotifier.value.add(element);
    }

    if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ) &&
        element.type == CategoryType.income) {
      incomeLastMonthNotifier.value.add(element);
    }

    if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ) &&
        element.type == CategoryType.expense) {
      expenseLastMonthNotifier.value.add(element);
    }
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  overviewNotifier.notifyListeners();
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  todayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  yesterdayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  incomeNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expenseNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  incomeTodayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  incomeYesterdayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  expenseTodayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  expenseYesterdayNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  lastWeekNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  incomeLastWeekNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  expenseLastWeekNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  lastMonthNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  incomeLastMonthNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member
  expenseLastMonthNotifier.notifyListeners();
}
