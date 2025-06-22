import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

abstract class OnboardingLocalDataSource {
  Future<void> cacheOnboardingStatus();
  Future<bool> getOnboardingStatus();
}

const kOnboardingStatusKey = 'isOnboardingCompleted';

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences _prefs;

  OnboardingLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheOnboardingStatus() async {
    await _prefs.setBool(kOnboardingStatusKey, true);
  }

  @override
  Future<bool> getOnboardingStatus() async {
    return _prefs.getBool(kOnboardingStatusKey) ?? false;
  }
}
