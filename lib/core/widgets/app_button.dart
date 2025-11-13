import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool loading;
  final Function()? onTap;
  final String text;

  const AppButton({super.key, this.onTap, required this.text,this.loading=false});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      style: ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 54))),
      onPressed:loading?null: onTap,
      child: loading?CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary,): Text(text),
    );
  }
}