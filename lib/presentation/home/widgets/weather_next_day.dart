import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/models/forecast_day.dart';
import 'package:weather/presentation/resources/colors.dart';

class WeatherNextDay extends StatefulWidget {
  ForecastDay forecastDay;

  WeatherNextDay(this.forecastDay);

  @override
  State<WeatherNextDay> createState() => _WeatherNextDayState();
}

class _WeatherNextDayState extends State<WeatherNextDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: AppColors.gray8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 120,
            height: 40,
            child: Text(
              DateFormat('EEEE').format(
                DateFormat("yyyy-MM-dd").parse(
                  (widget.forecastDay.date).toString(),
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 26,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: CachedNetworkImage(
              imageUrl: 'http:' + widget.forecastDay.day.condition.icon,
              fit: BoxFit.cover,
              color: (widget.forecastDay.day.condition.text == 'Sunny' ||
                      widget.forecastDay.day.condition.text == 'Partly cloudy')
                  ? Colors.yellow
                  : Colors.white,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Row(
            children: [
              Text(
                widget.forecastDay.day.mintempC.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.forecastDay.day.maxtempC.toString(),
                style: const TextStyle(
                  color: AppColors.gray5,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
