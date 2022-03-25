import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/models/forecast_day.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/injection.dart';
import 'package:weather/presentation/bloc/cubit/weather_cubit.dart';
import 'package:weather/presentation/bloc/cubit/weather_state.dart';
import 'package:weather/presentation/resources/colors.dart';
import 'package:weather/presentation/resources/dimensions.dart';
import 'package:weather/presentation/widgets/weather_next_day.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<HomeScreen> {
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
    print("Call Build");
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WeatherCubit, WeatherState>(
          bloc: weatherCubit,
          builder: (context, state) {
            if (state is WeatherInitial) {
              print("WeatherInitial");
              return const Center();
            } else if (state is WeatherLoading) {
              print("WeatherLoading");
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              print("WeatherLoaded");
              return _build(state.weather);
            } else {
              print("Loi");
              return const Center(
                child: Text('Loi'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _build(Weather weather) {
    timestamp = weather.location.localtimeEpoch;
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    time = datetime.hour;
    //time = 19;
    print(datetime);
    print(time);
    return Container(
      width: AppDimensions.d100w,
      height: AppDimensions.d100h,
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
      child: Column(
        children: [
          _currentWeather(context, weather),
          const SizedBox(
            height: 20,
          ),
          _futureWeather(context, weather),
        ],
      ),
    );
  }

  Widget _currentWeather(context, weather) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd").parse(weather.location.localtime);
    return SizedBox(
      width: AppDimensions.d100w,
      height: AppDimensions.d45h,
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
            child: Image.network(
              'http:' + weather.current.condition.icon,
              color: AppColors.yellow,
              fit: BoxFit.cover,
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

  Widget _futureWeather(context, weather) {
    List<ForecastDay> list = weather.forecast.forecastday;
    return SizedBox(
      width: AppDimensions.d100w,
      height: AppDimensions.d36h,
      child: ListView.builder(
        itemCount: weather.forecast.forecastday.length,
        itemBuilder: (context, index) {
          return WeatherNextDay(list[index]);
        },
      ),
    );
  }
}
