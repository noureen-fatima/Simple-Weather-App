import 'package:my_app/ui/weather/weather_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/weather_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: WeatherView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: WeatherService)
  ],
)
class AppSetup {
  /** Serves No Purpose */
}
