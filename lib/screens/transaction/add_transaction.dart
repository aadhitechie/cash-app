import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:money_manager/db_functions/catagory_db.dart';
import 'package:money_manager/db_functions/filteration_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/models/catagory_data_model.dart';
import 'package:money_manager/models/transaction_data_model.dart';
import 'package:money_manager/screens/navigator.dart';

import '../catetory/category.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CatagoryModel? selectedCategoryModel;
  String? categoryID;
  final TextEditingController amountEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: width * 0.95,
                  height: height * 0.7,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 10, 138, 218),
                        Color.fromARGB(255, 14, 135, 195)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.white,
                                    value: CategoryType.income,
                                    groupValue: selectedCategoryType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCategoryType =
                                            CategoryType.income;
                                        categoryID = null;
                                      });
                                    },
                                  ),
                                  const Text('Income')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.white,
                                    value: CategoryType.expense,
                                    groupValue: selectedCategoryType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCategoryType =
                                            CategoryType.expense;
                                        categoryID = null;
                                      });
                                    },
                                  ),
                                  const Text('Expense')
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          TextButton.icon(
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                fixedSize: MaterialStateProperty.all(
                                    Size(width * 0.35, height * 0.01)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final selectedDateTemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDateTemp == null) {
                                  return;
                                } else {
                                  setState(() {
                                    selectedDate = selectedDateTemp;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
                              label: Text(
                                selectedDate == null
                                    ? 'Select Date'
                                    : parseDate(selectedDate!),
                                style: const TextStyle(color: Colors.black),
                              )),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ScreenCategory()));
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.category_rounded,
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 132, 187, 199),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 172, 229, 189),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              hint: const Text('Select Category'),
                              value: categoryID,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Category Items is Empty';
                                } else {
                                  return null;
                                }
                              },
                              items: (selectedCategoryType ==
                                          CategoryType.income
                                      ? CategoryDB().incomeCategoryNotifier
                                      : CategoryDB().expenseCategoryNotifier)
                                  .value
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                  onTap: () {
                                    selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectValue) {
                                setState(() {
                                  categoryID = selectValue;
                                });
                              }),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Amount value is empty';
                              } else {
                                return null;
                              }
                            },
                            controller: amountEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 132, 187, 199),
                              hintText: 'Amount',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.045,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 255, 255)),
                              minimumSize: MaterialStateProperty.all(
                                  Size(width * 0.85, height * 0.05)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                transactionAdd();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(10),
                                    backgroundColor: Colors.white,
                                    duration: const Duration(seconds: 5),
                                    content: Row(
                                      children: const [
                                        Text(
                                          "Warning:",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 19),
                                        ),
                                        Text(
                                          ' Form is Empty',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          ' !!!',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 19),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> transactionAdd() async {
    final amountText = amountEditingController.text.trim();

    if (selectedDate == null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
      type: selectedCategoryType!,
      catagory: selectedCategoryModel!,
      date: selectedDate!,
      amount: parsedAmount,
    );
    TransactionDB.instance.addTransaction(model);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const ScreenNavigator(),
      ),
    );

    filterFunction();
    TransactionDB.instance.refresh();
    TransactionDB.instance.refreshHome();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 8, 132, 163),
        duration: Duration(seconds: 5),
        content: Text("Transaction added succefully  ✓"),
      ),
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
