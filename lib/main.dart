import 'package:ecomcons/NewDesign/Pages/CartPage.dart';
import 'package:ecomcons/NewDesign/Pages/Home.dart';
import 'package:ecomcons/Pages/LogInPage.dart';
import 'package:ecomcons/Services/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51LsKNlSDWxk95MAXkmuwPcFHsgxsgiDt7phdWSdRPwjR6uyecQDF0T0CLZ8QAGa0i2UE6frwQMEXpQp6pg974wHQ00811i8eoE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()
          ),
        
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Checking()
      ),
    );
    
  }
}


class Checking extends StatelessWidget {
  const Checking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
       if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
          child: CircularProgressIndicator(),
        );
        }
        else if(snapshot.hasData){
          return NhomePage();
        }
        else if(snapshot.hasError){
          return Center(child: Text("Something Went Wrong"),);
        }
        else{
          return LogIn();
        }
        
      },
    );
  }
}
