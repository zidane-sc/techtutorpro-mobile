part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final int currentPageIndex;
  final bool isOnboardingCompleted;

  const OnboardingState({
    this.currentPageIndex = 0,
    this.isOnboardingCompleted = false,
  });

  OnboardingState copyWith({
    int? currentPageIndex,
    bool? isOnboardingCompleted,
  }) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
    );
  }

  @override
  List<Object> get props => [currentPageIndex, isOnboardingCompleted];
}
