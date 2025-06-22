import 'package:injectable/injectable.dart';

@lazySingleton
class DummyService {
  Future<String> getName() async => 'Hello from DummyService!';
}
