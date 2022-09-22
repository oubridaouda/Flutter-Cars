import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourth_training/services/authentification.dart';
import 'package:fourth_training/services/dbServices.dart';
import 'package:fourth_training/views/detail/carDetail.dart';
import 'package:fourth_training/views/login/login.dart';
import 'package:fourth_training/views/profile/profile.dart';
import 'package:fourth_training/wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/carModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(value: AuthService().user, initialData: null),
        StreamProvider<List<Car>>.value(value: DatabaseService().cars, initialData: const []),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Cars',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white)
      ),
      initialRoute: "/",
      routes: {
        "/": (context)=>Wrapper(),
        "/profile": (context)=>Profile(),
        "/detail": (context)=>CarDetail()
      },
    );
  }
}
