import 'package:flutter/material.dart';
import 'package:subterranean_descent/navigation.dart';

class MainMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Text('the game',
                  style: TextStyle(color: Colors.black, fontSize: 40)),
              Spacer(),
              ElevatedButton(
                child: const Text('New game'),
                onPressed: () {
                  Navigation.navigateTo(RouteKey.initial);
                },
              ),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  Navigation.navigateTo(RouteKey.initial);
                },
              ),
              ElevatedButton(
                child: const Text('gg'),
                onPressed: () {
                  Navigation.navigateTo(RouteKey.initial);
                },
              ),
              Spacer(),
            ],
          ),
        ),
        backgroundColor: Colors.green,
      );
}
