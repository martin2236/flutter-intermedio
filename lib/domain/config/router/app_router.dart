
import 'package:go_router/go_router.dart';
import 'package:permissions/presentation/screens/screens.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
        ),
        
        GoRoute(
        path: '/giroscopio',
        builder: (context, state) => const GiroscopioScreen(),
        ),
        
        GoRoute(
        path: '/acelerometro',
        builder: (context, state) => const AcelerometroScreen(),
        ),
        
        GoRoute(
        path: '/magnetometro',
        builder: (context, state) => const MagnetometroScreen(),
        ),
        
        GoRoute(
        path: '/giroscopio-bola',
        builder: (context, state) => const GiroscopioBolaScreen(),
        ),

        
        GoRoute(
        path: '/brujula',
        builder: (context, state) => const BrujulaScreen(),
        )
  ]
);