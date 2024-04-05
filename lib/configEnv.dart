import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ENV {
  String? get apiURL;
}
class configEnv implements ENV{
  @override
  String? get apiURL => dotenv.get("API_URL");
}