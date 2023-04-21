import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/weather/weather_state_notifier.dart';
import 'package:new_weather/presentation/screens/empty_state_screen.dart';

class SearchWidget extends ConsumerWidget {
  final Color iconColor = Colors.white;
  final Color cursorColor = Colors.white;
  final Color textColor = Colors.white;

  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      autofocus: true,
      style: TextStyle(
        color: textColor,
      ),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      cursorColor: cursorColor,
      onChanged: (query) {
        if (query.length > 3) {
          ref.read(weatherValueProvider.notifier).getWeather(query: query);
        } else if (query.isEmpty) {
          //ref.read(weatherValueProvider.notifier).getWeather();
          const EmptyStateWidget();
        }
      },
      enableSuggestions: true,
      decoration: InputDecoration(
        hintText: 'Search City',
        hintStyle: TextStyle(
          color: Colors.blue.shade100,
        ),
        icon: Icon(
          Icons.search,
          color: iconColor,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
  //debounce metoda koja ceka dok korisnik nije prestao upisivat da se api zove samo jednom
