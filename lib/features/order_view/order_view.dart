import 'package:demomanager/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(AppStrings.order,style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
    );
  }
}
