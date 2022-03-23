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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
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
              child: Image.network(
                'http:' + widget.forecastDay.day.condition.icon,
                color: widget.forecastDay.day.condition.text == 'clear'
                    ? Colors.yellow
                    : Colors.white,
                fit: BoxFit.cover,
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
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
