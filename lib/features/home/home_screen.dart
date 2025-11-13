import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/page_cubit/page_cubit.dart';
import '../../core/widgets/app_bottom_bar.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: BlocBuilder<PageCubit, int>(
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: AppBottomBar(currentIndex: state, onTap: (int p1) {
                context.read<PageCubit>().setPage(p1);
              },),
              body: PageView(
                controller: context.read<PageCubit>().controller,
                children: [
                  HomeView(),
                  HomeView(),
                  HomeView(),
                ],
              ));
        },
      ),
    );
  }
}
