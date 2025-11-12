import 'package:demomanager/core/services/firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: IconButton(onPressed: (){
          FirebaseAuthService().signOut();
        }, icon: Icon(Icons.logout)),
      ),
    );
  }
}
