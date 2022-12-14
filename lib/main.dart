import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/catagory_data_model.dart';
import 'package:money_manager/models/transaction_data_model.dart';
import 'package:money_manager/models/username_data_model.dart';
import 'package:money_manager/screens/splash_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';

const saveKeyValue = 'UserRegistered';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeTimeZone();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CatagoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatagoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(UserNameModelAdapter().typeId)) {
    Hive.registerAdapter(UserNameModelAdapter());
  }
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const ScreenSplash(),
    );
  }
}
