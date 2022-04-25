import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';

import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: BlocProvider.of<WeatherBloc>(context),
        builder: (BuildContext context, WeatherState state) {
          // Changing the UI based on the current state
          if (state is WeatherInitial) {
            return buildInitialInput(context);
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(state.weather, context);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(
      child: cityInputField(context),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperature.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        cityInputField(context),
      ],
    );
  }

  Container cityInputField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05, left: 10, right: 10),
      height: MediaQuery.of(context).size.height * 0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),

      /// TextField Search
      child: TextField(
        style: const TextStyle(
            color: Colors.black, decoration: TextDecoration.none),
        cursorColor: Colors.black,
        onSubmitted: submitCityName,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
                color: Colors.grey.shade700, decoration: TextDecoration.none),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              size: 20,
              color: Colors.black,
            ),
            suffixIcon: const Icon(
              CupertinoIcons.location_solid,
              size: 20,
              color: Colors.black,
            ),
            // contentPadding: EdgeInsets.all(15),
            border: InputBorder.none),
      ),
    );
  }

  void submitCityName(String cityName) {
    print(cityName);
    // Get the Bloc using the BlocProvider
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
    // Initiate getting the weather
  }
}
