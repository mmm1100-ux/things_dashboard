import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:things_dashboard/core/glob.dart';
import 'package:things_dashboard/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  runApp(const MyApp());
}
// @override
// void initState() {
//   initPusher();
//   super.initState();
// }
//
// void initPusher() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String deviceId = await Pushe.getDeviceId();
//   await prefs.setString('deviceId', deviceId); // ذخیره کردن DeviceId در حافظه
//
//   print('DeviceId saved: $deviceId');
//   print(
//       '===Device============================= ID>>>>>>>>>>>>>>>>>>>>: $deviceId');
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(GlobeController());
    return GetMaterialApp(
      title: 'ThingsBoard Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffE57C23),
        ),
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xffE57C23),
          disabledColor: Colors.grey,
        ),
        primaryColor: const Color(0xffE57C23),
        scaffoldBackgroundColor: const Color(0xffF8F1F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffE8AA42),
          titleTextStyle: TextStyle(
            fontFamily: 'iranSansNum',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        fontFamily: 'iranSansNum',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xffE57C23),
        scaffoldBackgroundColor: const Color.fromARGB(255, 46, 35, 78),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 14, 4, 23),
          titleTextStyle: TextStyle(
            fontFamily: 'iranSansNum',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        indicatorColor: Colors.blue,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith(
            (states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue;
              }
              return Colors.blue;
            },
          ),
        ),
        tabBarTheme: const TabBarTheme(labelColor: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xffE57C23),
          disabledColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(disabledBackgroundColor: Colors.grey),
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
        dialogTheme: const DialogTheme(
          backgroundColor: Color.fromARGB(255, 46, 35, 78),
        ),
        fontFamily: 'iranSansNum',
      ),
      themeMode: ThemeMode.light,
      locale: const Locale('fa', 'IR'),
      fallbackLocale: const Locale('fa', 'IR'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppRouter.getPages(),
    );
  }
}