import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'l10n/language_service.dart';
import 'theme/theme_service.dart';
import 'theme/app_theme.dart';
import 'widget/home_screen.dart';
import 'widget/cart_page.dart';
import 'widget/address_edit_page.dart';
import 'widget/map_picker_page.dart';
import 'widget/settings_page.dart';
import 'widget/wishlist_page.dart';
import 'Notification/notification_page.dart';
import 'Promotions/Promotions_page.dart';
import 'Book/book_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService().currentLanguage,
      builder: (context, languageCode, child) {
        return Consumer<ThemeService>(
          builder: (context, themeService, _) {
            return MaterialApp(
              title: 'Mobile App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: const SplashScreen(),
              routes: {
                '/login': (context) => const LoginPage(),
                '/home': (context) => const HomeScreen(),
                '/cart': (context) => const CartPage(),
                '/address_edit': (context) => const AddressEditPage(),
                '/map_picker': (context) => const MapPickerPage(),
                '/settings': (context) => const SettingsPage(),
                '/wishlist': (context) => const WishlistPage(),
                '/notifications': (context) => NotificationPage(),
                '/promotions': (context) => PromotionsPage(),
                '/book_store': (context) => BookStorePage(),
              },
            );
          },
        );
      },
    );
  }
}

