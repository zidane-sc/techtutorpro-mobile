import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techtutorpro/features/account/presentation/bloc/account_bloc.dart';
import 'package:techtutorpro/features/account/presentation/pages/account_page.dart';
import 'package:techtutorpro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/purchased_course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/pages/course_list_page.dart';
import 'package:techtutorpro/features/courses/presentation/pages/my_courses_page.dart';
import 'package:techtutorpro/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:techtutorpro/features/transaction/presentation/pages/transactions_page.dart';
import 'package:techtutorpro/injection.dart';
import 'package:techtutorpro/router/app_router.dart';

class MainPage extends StatefulWidget {
  final int? tabIndex;
  const MainPage({super.key, this.tabIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabIndex != null && widget.tabIndex != _selectedIndex) {
      _onItemTapped(widget.tabIndex!);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => getIt<CourseBloc>(),
      child: const CourseListPage(),
    ),
    BlocProvider(
      create: (context) => getIt<PurchasedCourseBloc>(),
      child: const MyCoursesPage(),
    ),
    BlocProvider(
      create: (context) => getIt<TransactionBloc>(),
      child: const TransactionsPage(),
    ),
    BlocProvider(
      create: (context) => getIt<AccountBloc>(),
      child: const AccountPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.goNamed(AppRoute.login.name);
        }
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'My Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
