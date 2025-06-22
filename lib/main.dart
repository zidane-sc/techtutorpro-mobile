import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techtutorpro/core/theme/app_theme.dart';
import 'package:techtutorpro/features/account/presentation/bloc/account_bloc.dart';
import 'package:techtutorpro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_detail/course_detail_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_material_bloc.dart';
import 'package:techtutorpro/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:techtutorpro/injection.dart';
import 'package:techtutorpro/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final prefs = await SharedPreferences.getInstance();
  final isOnboardingCompleted = prefs.getBool(kOnboardingStatusKey) ?? false;

  final initialRoute = isOnboardingCompleted ? '/login' : '/onboarding';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<CourseBloc>()),
        BlocProvider(create: (_) => getIt<CourseDetailBloc>()),
        BlocProvider(create: (_) => getIt<CourseMaterialBloc>()),
        BlocProvider(create: (_) => getIt<AccountBloc>()),
        BlocProvider(create: (_) => getIt<TransactionBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router(initialLocation: initialRoute),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
