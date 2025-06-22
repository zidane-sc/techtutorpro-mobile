import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:techtutorpro/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:techtutorpro/injection.dart';
import 'package:techtutorpro/router/app_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  final List<Widget> _slides = [
    const OnboardingSlide(
      animationPath: 'assets/animations/onboarding_learn.json',
      title: 'Welcome to TechTutor Pro!',
      description:
          'Your journey to mastering new skills starts here. Learn from the best, at your own pace.',
    ),
    const OnboardingSlide(
      animationPath: 'assets/animations/onboarding_courses.json',
      title: 'Discover Thousands of Courses',
      description:
          'Explore a vast library of courses on programming, design, business, and more.',
    ),
    const OnboardingSlide(
      animationPath: 'assets/animations/onboarding_payment.json',
      title: 'Seamless Learning Experience',
      description:
          'Easy payments, offline access, and a supportive community. Your success is our priority.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().pageChanged(index);
                    },
                    itemBuilder: (context, index) {
                      return _slides[index];
                    },
                  ),
                  Positioned(
                    bottom: 40,
                    left: 24,
                    right: 24,
                    child: _buildFooter(context, state),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context, OnboardingState state) {
    final isLastPage = state.currentPageIndex == _slides.length - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page indicator
        Row(
          children: List.generate(
            _slides.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 8),
              height: 8,
              width: state.currentPageIndex == index ? 24 : 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        // Next/Get Started Button
        ElevatedButton(
          onPressed: () {
            if (isLastPage) {
              context.read<OnboardingCubit>().completeOnboarding();
              context.goNamed(AppRoute.login.name);
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isLastPage
                  ? Icons.check_rounded
                  : Icons.arrow_forward_ios_rounded,
              key: ValueKey<bool>(isLastPage),
            ),
          ),
        ),
      ],
    );
  }
}
