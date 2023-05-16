import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/expenses.dart';
//import 'package:flutter/services.dart';

var kColorSceme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(201, 25, 139, 120),
);

var kDarkColorSceme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(163, 22, 65, 92),
);
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
  //[DeviceOrientation.portraitUp],
  //).then((fn) {

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorSceme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorSceme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 4,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorSceme.primaryContainer,
              foregroundColor: kDarkColorSceme.onPrimaryContainer,
            ),
          )),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorSceme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(178, 32, 185, 139),
          foregroundColor: Colors.black,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorSceme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 4,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSceme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kColorSceme.onSecondaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const ExpenseScreen(),
    ),
  );
}
