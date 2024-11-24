// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_weather/Screens/Login.dart';
// import 'package:flutter_weather/provider/weatherProvider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => WeatherProvider(),
//       child: MaterialApp(
//         title: 'App Weather',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           appBarTheme: AppBarTheme(
//             iconTheme: IconThemeData(
//               color: Colors.blue,
//             ),
//             elevation: 0,
//           ),
//           scaffoldBackgroundColor: Colors.white,
//           primaryColor: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           colorScheme:
//               ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
//         ),
//         home: Login(),
//       ),
//     );
//   }
// }

import 'package:weather_app/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather_app/Screens/hourlyWeatherScreen.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/widgets/profilePage.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // make sure firebase is initialized before we run our application
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(
          create: (_) => WeatherProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Login(),
        routes: {
          HourlyScreen.routeName: (myCtx) => HourlyScreen(),
          EditProfileScreen.routeName: (ctx) => EditProfileScreen(),// dang ki editprofile
        },
      ),
    );
  }
}
