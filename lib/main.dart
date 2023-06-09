import 'package:farmmitra/provider/auth_provider.dart';
import 'package:farmmitra/provider/current_user_provider.dart';
import 'package:farmmitra/screens/authenticate/signin.dart';
import 'package:farmmitra/screens/wrapper.dart';
import 'package:farmmitra/services/Maps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GenerateMaps()),
        ChangeNotifierProvider(create: (_) => CurrentUserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
