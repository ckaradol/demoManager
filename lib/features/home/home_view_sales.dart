import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/bloc/order_bloc/order_bloc.dart';
import 'package:demomanager/core/models/sale_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewSales extends StatelessWidget {
  const HomeViewSales({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return BlocProvider(
      create: (_) {
        if (authState is AuthLogin) {
          return OrderBloc()..add(OrderInitialEvent(userId: authState.user.uid, sale: true));
        } else {
          return OrderBloc();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Satış Paneli"), elevation: 0),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoad) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatCard(title: "Toplam Sipariş", value: "${state.sales.length} adet", icon: Icons.shopping_bag,context: context),
                    const SizedBox(height: 12),

                    _buildStatCard(title: "Toplam Ciro", value: "${top(state.sales).toStringAsFixed(2)} TL", icon: Icons.currency_lira,context: context),
                    const SizedBox(height: 12),

                    _buildStatCard(title: "Kazanılan Prim", value: "${commission(state.sales).toStringAsFixed(2)} TL", icon: Icons.trending_up,context: context),

                    const SizedBox(height: 20),
                    Text("Sipariş Listesi", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),

                    ...state.sales.map((order) => _buildOrderTile(order,context)),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required IconData icon,required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primaryFixed),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTile(SaleModel order,BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sipariş: ${order.count*(order.product?.price??0)} TL", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Tarih: ${formatDate(order.createdDate,context)}"),
            ],
          ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
              child: const Text("Doktor Satışı", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}
double top(List<SaleModel> sales){
  double toplam=0;
  for(var data in sales){
    toplam+=data.count*(data.product?.price??0);
  }
  return toplam;
}double commission(List<SaleModel> sales){
  double toplam=0;
  for(var data in sales){
    toplam+=data.count*(data.product?.price??0)*(data.product?.commission.rate??1);
  }
  return toplam;
}

String formatDate(DateTime date,BuildContext context) {
  return DateFormat("d MMM yyyy HH:mm",context.locale.languageCode).format(date);
}