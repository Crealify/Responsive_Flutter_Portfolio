import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anilbhattarai_portfolio/view/splash/splash_view.dart';
import 'package:anilbhattarai_portfolio/view_model/getx_controllers/portfolio_controller.dart';
import 'package:anilbhattarai_portfolio/res/constants.dart';

// Import views for routing (assuming they exist, otherwise placeholder)
// Since this is a starter template, we configure basic GetX routes
import 'package:anilbhattarai_portfolio/view/home/home.dart';
import 'package:anilbhattarai_portfolio/view_model/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Controllers
  Get.put(AppController());

  Get.put(PortfolioController());

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio Starter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppConstants.bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/HomePage', page: () => const HomePage()),
        // Add other routes here, e.g. /admin_dashboard
      ],
    );
  }
}
