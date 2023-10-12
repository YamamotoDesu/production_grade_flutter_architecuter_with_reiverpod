import 'package:production_grade_flutter_architecuter_with_reiverpod/src/utills/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseProdUrl = "http://productionURL.com";
  static const baseTestUrl = "https://dummyjson.com";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
