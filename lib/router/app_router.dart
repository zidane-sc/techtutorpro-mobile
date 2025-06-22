import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techtutorpro/features/account/presentation/pages/edit_profile_page.dart';
import 'package:techtutorpro/features/account/presentation/pages/help_center_page.dart';
import 'package:techtutorpro/features/account/presentation/pages/settings_page.dart';
import 'package:techtutorpro/features/auth/presentation/pages/login_page.dart';
import 'package:techtutorpro/features/auth/presentation/pages/register_page.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/pages/course_detail_page.dart';
import 'package:techtutorpro/features/courses/presentation/pages/course_list_page.dart';
import 'package:techtutorpro/features/courses/presentation/pages/course_material_page.dart';
import 'package:techtutorpro/features/courses/presentation/pages/feedback_page.dart';
import 'package:techtutorpro/features/dashboard/presentation/pages/main_page.dart';
import 'package:techtutorpro/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:techtutorpro/features/payment/presentation/pages/payment_summary_page.dart';
import 'package:techtutorpro/features/transaction/presentation/pages/transactions_page.dart';

enum AppRoute {
  onboarding,
  login,
  register,
  dashboard,
  editProfile,
  settings,
  helpCenter,
  courseDetail,
  courseMaterial,
  courseFeedback,
}

class AppRouter {
  AppRouter._();

  static GoRouter router({String initialLocation = '/onboarding'}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/onboarding',
          name: AppRoute.onboarding.name,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/login',
          name: AppRoute.login.name,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: AppRoute.register.name,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/dashboard',
          name: AppRoute.dashboard.name,
          builder: (context, state) {
            final tabIndex = state.extra as int?;
            return MainPage(tabIndex: tabIndex);
          },
          routes: [
            GoRoute(
              path: 'edit-profile',
              name: AppRoute.editProfile.name,
              builder: (context, state) => const EditProfilePage(),
            ),
            GoRoute(
              path: 'settings',
              name: AppRoute.settings.name,
              builder: (context, state) => const SettingsPage(),
            ),
            GoRoute(
              path: 'help-center',
              name: AppRoute.helpCenter.name,
              builder: (context, state) => const HelpCenterPage(),
            ),
            GoRoute(
              path: 'course/:id',
              name: AppRoute.courseDetail.name,
              builder: (context, state) {
                final courseId = state.pathParameters['id']!;
                return CourseDetailPage(courseId: courseId);
              },
              routes: [
                GoRoute(
                  path: 'material',
                  name: AppRoute.courseMaterial.name,
                  builder: (context, state) {
                    final course = state.extra as CourseEntity;
                    return CourseMaterialPage(course: course);
                  },
                  routes: [
                    GoRoute(
                      path: 'feedback',
                      name: AppRoute.courseFeedback.name,
                      builder: (context, state) {
                        final course = state.extra as CourseEntity;
                        return FeedbackPage(course: course);
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'payment-summary',
              name: 'paymentSummary',
              builder: (context, state) {
                final course = state.extra as CourseEntity;
                return PaymentSummaryPage(course: course);
              },
            ),
            GoRoute(
              path: 'transactions',
              name: 'transactions',
              builder: (context, state) => const TransactionsPage(),
            ),
          ],
        ),
      ],
    );
  }
}
