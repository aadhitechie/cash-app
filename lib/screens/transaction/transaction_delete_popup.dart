import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/filteration_db.dart';
import 'package:money_manager/db_functions/transaction_db.dart';
import 'package:money_manager/models/transaction_data_model.dart';

Future<void> showTransactionDelete(
    BuildContext context, TransactionModel model) async {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete',
          textAlign: TextAlign.center,
        ),
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Selected transaction will be deleted permanetly',
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  TransactionDB.instance.deleteTransaction(model.id!);
                  filterFunction();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
