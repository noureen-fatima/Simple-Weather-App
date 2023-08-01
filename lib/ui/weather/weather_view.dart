import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:my_app/ui/weather/weather_viewmodal.dart';
import 'package:stacked/stacked.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherViewModel>.reactive(
      viewModelBuilder: () => WeatherViewModel(),
      onModelReady: (viewModel) => viewModel.fetchData(),
      builder: (context, viewModel, child) {
        final Brightness brightness = Theme.of(context).brightness;
        final String backgroundImage =
            brightness == Brightness.light ? 'Light.png' : 'Dark.png';
        final Color themeColor = brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF194348);
        IconData weatherIcon = viewModel
                .mapWeatherIcon(viewModel.weather?.weather[0].icon ?? '') ??
            Icons.error;

        if (viewModel.isBusy || viewModel.weather == null) {
          // ViewModel is still fetching data
          return const Center(
            child: CircularProgressIndicator(), // Circular loading indicator
          );
        } else if (viewModel.hasError) {
          // Error occurred while fetching data
          return Center(
            child: Text('Error: ${viewModel.error}'),
          );
        } else {
          // Data is fetched successfully, show the weather information
          return Scaffold(
            body: LiquidPullToRefresh(
              color: themeColor,
              onRefresh: viewModel.fetchData,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/$backgroundImage'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.5, top: 30),
                            child: Icon(
                              weatherIcon,
                              size: 160,
                              color: themeColor,
                            ),
                          ),
                          const SizedBox(width: 15)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            viewModel.weather?.main.temp.toString() ?? 'N/A',
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 65,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '°F',
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 65,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 15, height: 100),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            viewModel.weather?.name ?? 'N/A',
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 15, height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
