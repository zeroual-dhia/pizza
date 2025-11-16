import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza/models/cartmodel.dart';
import 'package:pizza/models/navigation.dart';
import 'package:pizza/models/pizza.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/routes/allPizza.dart';
import 'package:pizza/routes/home.dart';
import 'package:pizza/routes/auth/login.dart';
import 'package:pizza/routes/auth/register.dart';
import 'package:pizza/routes/info.dart';
import 'package:pizza/routes/wrapper.dart';
import 'package:pizza/server/auth.dart';
import 'package:pizza/server/services/user.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [  
    GoRoute(
      path: '/',
      builder: (context, state) => Wrapper(),
      routes: [
        GoRoute(path: 'login', builder: (context, state) => const Login()),
        GoRoute(
          path: 'register',
          builder: (context, state) => const Register(),
        ),
        GoRoute(
          path: 'home',
          builder: (context, state) => Home(),
          routes: [
            GoRoute(path: 'seeAll', builder: (context, state) => Allpizza()),
            GoRoute(
              path: 'pizzaInfo/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']; 
                return PizzaInfo(id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => Favourite()),
        ChangeNotifierProvider(create: (context) => Pizza()),
        StreamProvider<String?>.value(
          value: Auth().token,
          initialData: null,
          catchError: (_, __) => null,
        ),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        StreamProvider<MyUser?>.value(
          value: Auth().user,
          initialData: null,
          catchError: (_, __) => null,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
