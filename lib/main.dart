import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/order_provider.dart';
import 'screens/home_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/orders_screen.dart';
import 'widgets/main_layout.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LeatherEcommerceApp());
}

class LeatherEcommerceApp extends StatelessWidget {
  const LeatherEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp.router(
        title: 'Leather Ecommerce',
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Router configuration for navigation
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainLayout(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/shop',
      builder: (context, state) => const MainLayout(
        child: ShopScreen(),
      ),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return MainLayout(
          child: ProductDetailScreen(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const MainLayout(
        child: CartScreen(),
      ),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const MainLayout(
        child: CheckoutScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const MainLayout(
        child: ContactScreen(),
      ),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const MainLayout(
        child: OrdersScreen(),
      ),
    ),
  ],
);
