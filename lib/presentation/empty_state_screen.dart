import 'package:flutter/material.dart';
import 'package:new_weather/presentation/search_bar.dart';
import 'package:new_weather/presentation/search_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBar(),
          Center(
            child: Text(
                'Insert city name to find whats the weather like in wanted city!'),
          )
        ],
      ),
    );
  }
}
