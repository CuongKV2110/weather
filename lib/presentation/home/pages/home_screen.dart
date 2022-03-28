import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/models/forecast_day.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/injection.dart';
import 'package:weather/presentation/home/bloc/cubit/weather_cubit.dart';
import 'package:weather/presentation/home/bloc/cubit/weather_state.dart';
import 'package:weather/presentation/home/widgets/current_weather_widget.dart';
import 'package:weather/presentation/home/widgets/weather_next_day.dart';
import 'package:weather/presentation/resources/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherCubit weatherCubit = getIt();
  int timestamp = 0;
  int time = 0;

  @override
  void initState() {
    super.initState();
    weatherCubit.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WeatherCubit, WeatherState>(
          bloc: weatherCubit,
          builder: (context, state) {
            if (state is WeatherInitial) {
              return const Center();
            } else if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return _buildBody(state.weather);
            } else {
              return const Center(
                child: Text('Loi'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(Weather weather) {
    timestamp = weather.location.localtimeEpoch;
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    time = datetime.hour;
    print(datetime);
    print(time);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: (time < 12)
              ? [
                  AppColors.red,
                  AppColors.colorItem2,
                ]
              : (time < 18
                  ? [
                      AppColors.blue700,
                      AppColors.blue1,
                    ]
                  : [
                      AppColors.color19042B,
                      AppColors.color42329A,
                    ]),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _currentWeather(context, weather),
            const SizedBox(
              height: 20,
            ),
            _futureWeather(context, weather),
          ],
        ),
      ),
    );
  }

  Widget _currentWeather(context, weather) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd").parse(weather.location.localtime);
    return CurrentWeatherWidget(weather, tempDate);
  }

  Widget _futureWeather(context, weather) {
    List<ForecastDay> list = weather.forecast.forecastday;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if (index < list.length) {
            return WeatherNextDay(list[index]);
          } else {
            return const Divider(
              color: AppColors.gray8,
            );
          }
        },
      ),
    );
  }
}
