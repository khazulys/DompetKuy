import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'providers/transaction_provider.dart';
import 'providers/goal_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()..loadTransactions()),
        ChangeNotifierProvider(create: (_) => GoalProvider()..loadGoals()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final fTheme = themeProvider.isDarkMode ? AppTheme.darkTheme() : AppTheme.lightTheme();
          
          return MaterialApp(
            title: 'DompetKuy',
            debugShowCheckedModeBanner: false,
            theme: fTheme.toApproximateMaterialTheme(),
            builder: (context, child) {
              return FTheme(
                data: fTheme,
                child: child!,
              );
            },
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
