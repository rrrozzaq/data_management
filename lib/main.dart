import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './features/presentation/providers/kk_provider.dart';
import './features/presentation/providers/ktp_provider.dart';
import './features/presentation/pages/search_kk_page.dart';
import './features/presentation/pages/input_ktp_page.dart';
import './features/presentation/pages/home_page.dart';
import './features/presentation/pages/detail_kk_page.dart';
import 'features/presentation/providers/kk_detail_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KKProvider()),
        ChangeNotifierProvider(create: (_) => KTPProvider()),
        ChangeNotifierProvider(create: (_) => KKDetailProvider()),
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
      title: 'KTP Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/data-kk': (context) => SearchKKPage(), // Page for Data KK
        '/input-ktp': (context) => const InputKTPPage(), // Page for Input KTP
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail-kk') {
          final int kkId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return DetailKKPage(kkId: kkId);
            },
          );
        }
        return null; // If the route doesn't match, return null.
      },
    );
  }
}
