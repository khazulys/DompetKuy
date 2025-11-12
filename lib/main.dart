import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'providers/user_provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/goal_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_sheet.dart';

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
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
            home: const AppShell(),
          );
        },
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOnboarding();
    });
  }

  Future<void> _checkOnboarding() async {
    final userProvider = context.read<UserProvider>();
    
    while (userProvider.isLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!userProvider.isOnboarded && mounted) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const OnboardingSheet(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    if (userProvider.isLoading) {
      return Scaffold(
        backgroundColor: context.theme.colors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: context.theme.colors.primary,
          ),
        ),
      );
    }

    return const HomeScreen();
  }
}
