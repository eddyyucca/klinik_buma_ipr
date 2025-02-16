import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klinik_buma_ipr/utils/constants.dart';
import 'package:klinik_buma_ipr/utils/routes.dart';
import 'package:klinik_buma_ipr/providers/appointment_provider.dart';
import 'package:klinik_buma_ipr/providers/medical_record_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => MedicalRecordProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.home,
        onGenerateRoute: Routes.generateRoute,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              // Dismiss keyboard when tapping outside
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child!,
          );
        },
        // Error handling for the entire app
        navigatorObservers: [
          NavigatorObserver(),
        ],
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Halaman tidak ditemukan'),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Global error handling
class GlobalErrorHandler extends StatelessWidget {
  final Widget child;

  const GlobalErrorHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Terjadi kesalahan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorDetails.exception.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          (route) => false,
                        );
                      },
                      child: const Text('Kembali ke Beranda'),
                    ),
                  ],
                ),
              ),
            );
          };
          return child;
        },
      ),
    );
  }
}

// App lifecycle management
class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // App is visible and running in foreground
        break;
      case AppLifecycleState.inactive:
        // App is in an inactive state
        break;
      case AppLifecycleState.paused:
        // App is in background
        break;
      case AppLifecycleState.detached:
        // App is terminated
        break;
      case AppLifecycleState.hidden:
        // App is hidden
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
