import 'package:broker_app/injectionContainer.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'config/routes/route.dart';
import 'core/util/sharedPreference.dart';
void main() async {
  
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Routes appRoutes = Routes();
    return FutureBuilder<bool>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  initialRoute: snapshot.data == true ? "/homePage" : "/login",
                  onGenerateRoute: appRoutes.generateRoute,
                );
              
        }
      },

    );
  }
}

Future<bool> _getInitialRoute() async {
  final stored = await SharedPreferencesService.getString("tokenS");
  if (stored == null) {
    return false;
  }
  if (Jwt.isExpired(stored)) {
    return false;
  } else {
    return true;
  }
}
