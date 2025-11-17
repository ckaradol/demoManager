import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/enums/app/app_user_type.dart';
import 'package:demomanager/features/home/home_view_sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/page_cubit/page_cubit.dart';
import '../../core/widgets/app_bottom_bar.dart';
import '../order_view/order_view.dart';
import '../profile_view/profile_view.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return BlocProvider(
      create: (context) => PageCubit(),
      child: BlocBuilder<PageCubit, int>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: AppBottomBar(
              currentIndex: state,
              onTap: (int p1) {
                context.read<PageCubit>().setPage(p1);
              },
            ),
            body: PageView(
              controller: context.read<PageCubit>().controller,
              children: [
                if (authState is AuthLogin)
                  if (authState.userValue.role == AppUserType.doctor) HomeView() else HomeViewSales(),
                OrderView(),
                ProfileView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
