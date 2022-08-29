class Env {
  static Env? _instance;
  Env._() : super();

  static Env? get instance => _instance ??= Env._();

  late String baseUrl;
  late String apiKey;

  initEnv() {
    baseUrl = "https://api.openweathermap.org/data/2.5/";
    apiKey = "c7db1b70936f8ad949f690a3bab8a147";
  }

  // bool isTest = Platform.environment.containsKey('FLUTTER_TEST');
}
