import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/models/forecast_day.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/presentation/bloc/app_bloc.dart';
import 'package:weather/presentation/bloc/app_event.dart';
import 'package:weather/presentation/bloc/app_state.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/presentation/resources/colors.dart';
import 'package:weather/presentation/resources/dimensions.dart';
import 'package:weather/presentation/widgets/weather_next_day.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppBloc _appBloc = AppBloc();
  int timestamp = 0;
  int time = 0;

  @override
  void initState() {
    super.initState();
    print("initState");
    _appBloc.add(
      GetData(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _appBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).app_name),
          centerTitle: true,
        ),
        body: BlocBuilder(
          bloc: _appBloc,
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 12,
                ),
              );
            }

            if (state is Error) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: AppColors.red),
                ),
              );
            }

            if (_appBloc.weather != null) {
              timestamp = _appBloc.weather!.current.lastUpdatedEpoch;
              DateTime datetime =
                  DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
              time = datetime.hour;
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
                    _currentWeather(),
                    const SizedBox(
                      height: 20,
                    ),
                    _futureWeather(),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _currentWeather() {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd").parse(_appBloc.weather!.location.localtime);
    initializeDateFormatting('es');
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
            _appBloc.weather!.location.name,
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
            _appBloc.weather!.current.condition.text,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Image.network(
              'http:' + _appBloc.weather!.current.condition.icon,
              color: AppColors.yellow,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            _appBloc.weather!.current.tempC.toString(),
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

  Widget _futureWeather() {
    List<ForecastDay> list = _appBloc.weather!.forecast.forecastday;
    initializeDateFormatting('es');
    return SizedBox(
      width: AppDimensions.d100w,
      height: AppDimensions.d36h,
      child: ListView.builder(
        itemCount: _appBloc.weather!.forecast.forecastday.length,
        itemBuilder: (context, index) {
          return WeatherNextDay(list[index]);
        },
      ),
    );
  }
}
