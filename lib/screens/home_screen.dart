// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CustomerData(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              // OPTION 1:
              // title: Text(Provider.of<CustomerData>(context).name),

              // OPTION 2:
              // Text('${context.watch<CustomerData>().name}')

              // OPTION 3: RECOMMENDED WAY
              title: Consumer<CustomerData>(
                builder: ((context, value, child) {
                  return Text(value.name);
                }),
              ),
            ),
            body: WelcomeBanner(),
          );
        });
  }
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // OPTION 1: <listen: false> are used for functions
              // Provider.of<CustomerData>(context, listen: false)
              //     .changeName('Aira');

              // OPTION 2:
              context.read<CustomerData>().changeName('Aira');
            },
            child: Text('Greet'),
          ),
          // Text('Good Morning! ${Provider.of<CustomerData>(context).name}')
          Consumer<CustomerData>(
            builder: ((context, value, child) {
              return Text('Good Morning! ${value.name}');
            }),
          ),
        ],
      ),
    );
  }
}

class CustomerData with ChangeNotifier {
  String _name = '';

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  String get name => _name;
}
