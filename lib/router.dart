import 'package:get/get.dart';
import 'package:things_dashboard/pages/home/home.dart';
import 'package:things_dashboard/pages/home/home_binding.dart';
import 'package:things_dashboard/pages/home/home_controller.dart';
import 'package:things_dashboard/pages/login/login.dart';
import 'package:things_dashboard/pages/login/login_binding.dart';
import 'package:things_dashboard/pages/splash/splash.dart';
import 'package:things_dashboard/pages/splash/splash_binding.dart';

class AppRouter {
  static List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(
        name: "/",
        page: () => const Splash(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: "/login",
        page: () => const Login(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: "/home",
        page: () => const Home(),
        binding: HomeBinding(),
      ),

      // GetPage(
      //   name: "/settings",
      //   page: () => const Settings(),
      //   binding: SettingsBinding(),
      // ),
      // GetPage(
      //   name: "/personal",
      //   page: () => const Personal(),
      //   binding: PersonalBinding(),
      // ),
      // GetPage(
      //   name: "/",
      //   page: () => const Home(),
      //   binding: HomeBinding(),
      // ),
      // GetPage(
      //   name: "/profile",
      //   page: () => const Profile(),
      //   binding: ProfileBinding(),
      // ),
    ];
  }
}
