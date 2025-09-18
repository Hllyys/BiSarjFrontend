// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:frontend_bisarj/utils/app.constants.dart';
// import 'package:frontend_bisarj/utils/app_colors.dart';
// import 'package:frontend_bisarj/views/splash_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// final appNavigator = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   RequestConfiguration configuration = RequestConfiguration(
//     testDeviceIds: ['TEST_DEVICE_ID'],
//   );
//   MobileAds.instance.updateRequestConfiguration(configuration);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: appNavigator,
//       title: AppName,
//       builder: (context, child) {
//         return ScrollConfiguration(behavior: MyBehavior(), child: child!);
//       },
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'AirbnbCereal_W_Bk',
//         textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: Colors.white,
//         bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
//         dialogTheme: DialogThemeData(backgroundColor: Colors.white),
//         appBarTheme: AppBarTheme(
//           iconTheme: IconThemeData(color: Colors.black),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light,
//           ),
//         ),
//         dividerTheme: DividerThemeData(color: Colors.grey.shade200),
//         primarySwatch: Colors.blue,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//     BuildContext context,
//     Widget child,
//     ScrollableDetails details,
//   ) {
//     return child;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/splash_screen.dart';

final appNavigator = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Google Ads
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: ['TEST_DEVICE_ID']),
  );

  // GraphQL (Hive storage)
  await initHiveForFlutter();

  // GraphQL Client (Bearer <token>)
  final httpLink = HttpLink('http://192.168.1.222:6189/api/graphql');

  final authLink = AuthLink(
    getToken: () async {
      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString('token'); // login sonrası kaydedilen token
      return (t == null || t.isEmpty) ? null : 'Bearer $t';
    },
  );

  final link = authLink.concat(httpLink);

  final client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          navigatorKey: appNavigator,
          title: AppName,
          builder: (context, child) =>
              ScrollConfiguration(behavior: MyBehavior(), child: child!),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'AirbnbCereal_W_Bk',
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: primaryColor,
            ),
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
            dividerTheme: DividerThemeData(color: Colors.grey.shade200),
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // overscroll glow kapalı
  }
}
