import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/presentation/resources/colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  Weather weather;
  DateTime tempDate;
  CurrentWeatherWidget(this.weather, this.tempDate);

  @override
  Widget build(BuildContext context) {
    return _currentWeather(context, weather);
  }

  Widget _currentWeather(BuildContext context, weather) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            weather.location.name,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            weather.current.condition.text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: CachedNetworkImage(
              imageUrl: 'http:' + weather.current.condition.icon,
              fit: BoxFit.cover,
              color: AppColors.yellow,
            ),
          ),
          Text(
            weather.current.tempC.toString(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            DateFormat.yMd('es').format(tempDate),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
