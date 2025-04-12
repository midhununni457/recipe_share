import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "SofiaPro",
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF0a2533)),
            bodyMedium: TextStyle(color: Color(0xFF0a2533)),
            bodySmall: TextStyle(color: Color(0xFF0a2533)),
            displayLarge: TextStyle(color: Color(0xFF0a2533)),
            displayMedium: TextStyle(color: Color(0xFF0a2533)),
            displaySmall: TextStyle(color: Color(0xFF0a2533)),
            headlineLarge: TextStyle(color: Color(0xFF0a2533)),
            headlineMedium: TextStyle(color: Color(0xFF0a2533)),
            headlineSmall: TextStyle(color: Color(0xFF0a2533)),
            titleLarge: TextStyle(color: Color(0xFF0a2533)),
            titleMedium: TextStyle(color: Color(0xFF0a2533)),
            titleSmall: TextStyle(color: Color(0xFF0a2533)),
            labelLarge: TextStyle(color: Color(0xFF0a2533)),
            labelMedium: TextStyle(color: Color(0xFF0a2533)),
            labelSmall: TextStyle(color: Color(0xFF0a2533)),
          ),
        ),
        home: const Home(),
      ),
    ),
  );
}
