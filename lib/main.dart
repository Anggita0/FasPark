import 'package:faspark/screens/auth/login_petugas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import Providers
import 'providers/report_provider.dart';
import 'providers/record_provider.dart';

// Import Screens
import 'screens/report/form_report.dart';
import 'screens/record/record_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => RecordProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FasPark',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginPetugas());

          // case '/record':
          //   final args = settings.arguments;
          //   if (args is String) {
          //     return MaterialPageRoute(
          //       builder: (_) => RecordScreen(id: args), // ✅ FIXED HERE
          //     );
          //   }
            // return _errorRoute("ID tidak valid");
          case '/record':
            final args = settings.arguments;
            print("Arguments masuk ke /record: $args (${args.runtimeType})");
            if (args != null) {
              return MaterialPageRoute(
              builder: (_) => RecordScreen(id: args.toString()), // 🔁 aman untuk int/string
              );
            }
            return _errorRoute("ID tidak valid");



          default:
            return _errorRoute("Halaman tidak ditemukan");
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3EFCB),
        useMaterial3: true,
      ),
    );
  }

  MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(message)),
      ),
    );
  }
}
