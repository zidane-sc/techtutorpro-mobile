import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/onboarding/data/datasources/onboarding_local_datasource.dart';

part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingCubit(this._localDataSource) : super(const OnboardingState());

  void pageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }

  Future<void> completeOnboarding() async {
    await _localDataSource.cacheOnboardingStatus();
    emit(state.copyWith(isOnboardingCompleted: true));
  }
}
