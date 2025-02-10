import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/userprofile_provider.dart';
import 'Provider/favorite_provider.dart';
import 'Provider/quantity.dart';
import 'front_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => QuantityProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
       ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: UploadRecipes(),
        home: FrontPage(),
        // home: AppMainScreen(),
      ),
    );
  }
}