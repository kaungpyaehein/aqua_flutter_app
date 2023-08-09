import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purifed_water_flutter/screens/chat_screen.dart';
import 'package:purifed_water_flutter/screens/home_screen.dart';
import 'package:purifed_water_flutter/screens/info_screen.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = GoRouter(initialLocation: '/', routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: "/chat",
            builder: (context, state) {
              return const ChatScreen();
            },
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeScreen();
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: "/info",
            builder: (context, state) {
              return const InfoScreen();
            },
          ),
        ]),
      ],
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: navigationShell,
                  bottomNavigationBar: NavigationBar(
                      selectedIndex: navigationShell.currentIndex,
                      onDestinationSelected: (value) {
                        navigationShell.goBranch(value);
                      },
                      destinations: const [
                        NavigationDestination(
                            icon: Icon(Icons.chat_bubble_outline),
                            label: "Chat"),
                        NavigationDestination(
                            icon: Icon(Icons.home), label: "Home"),
                        NavigationDestination(
                            icon: Icon(Icons.person), label: "Info"),
                      ]),
                );
              } else {
                return const LoginScreen();
              }
            },
          ),
        );
      },
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
