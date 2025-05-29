import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager_app/providers/category_provider.dart';
import 'package:grocery_manager_app/providers/chart_provider.dart';
import 'package:grocery_manager_app/providers/order_provider.dart';
import 'package:grocery_manager_app/providers/product_provider.dart';
import 'package:grocery_manager_app/screens/bottomnav.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider()..getCategories(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider()..getProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider()..getOrders(),
        ),
        ChangeNotifierProvider(create: (context) => ChartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Bottomnav(),
    );
  }
}
