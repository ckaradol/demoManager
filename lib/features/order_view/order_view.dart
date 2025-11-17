import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/bloc/order_bloc/order_bloc.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/app/app_user_type.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(AppStrings.order, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
      body: BlocProvider(
        create: (context) {
          if (authState is AuthLogin) {
            return OrderBloc()..add(OrderInitialEvent(userId: authState.user.uid, region: authState.userValue.role == AppUserType.sales ? authState.userValue.trRegion.name : null));
          } else {
            return OrderBloc();
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoad) {
              return ListView(
                children: [
                  for (var data in state.sales)
                    ListTile(
                      leading: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(image: NetworkImage(data.product?.images.first ?? ""), fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(data.product?.name ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text("${data.count}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (authState is AuthLogin) {
                            FirestoreService().updateOrderData(docId: data.id, saleId: authState.userValue.id);
                          }
                        },
                        child: Text("Teslim Et"),
                      ),
                    ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
