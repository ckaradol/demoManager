import 'package:demomanager/core/bloc/auth_bloc/auth_bloc.dart';
import 'package:demomanager/core/services/firestore_service/firestore_service.dart';
import 'package:demomanager/core/services/navigator_service/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_strings.dart';
import '../enums/app/app_spacing.dart';
import '../helper/locations.dart';
import '../models/product_model.dart';
import 'app_button.dart';

class SalesModalBottom extends StatefulWidget {
  final int count;
  final ProductModel productModel;

  const SalesModalBottom({super.key, required this.productModel, required this.count});

  @override
  State<SalesModalBottom> createState() => _SalesModalBottomState();
}

class _SalesModalBottomState extends State<SalesModalBottom> {
  String? selectedIl;
  final TextEditingController productController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  TRRegion? selectedRegion;

  final iller = ilToRegion.keys.toList()..sort();

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.mediumSpace),

              Text(AppStrings.createSale, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.mediumSpace),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: AppStrings.selectCity, border: OutlineInputBorder()),
                items: iller.map((il) {
                  return DropdownMenuItem(value: il, child: Text(il));
                }).toList(),
                value: selectedIl,
                onChanged: (val) {
                  setState(() {
                    selectedIl = val;
                    selectedRegion = ilToRegion[val];
                  });
                },
              ),
              const SizedBox(height: AppSpacing.defaultSpace),

              if (selectedRegion != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.mediumSpace),
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.surfaceContainerHighest),
                  child: Text("${AppStrings.region}: ${selectedRegion?.name}", style: Theme.of(context).textTheme.bodyLarge),
                ),
              const SizedBox(height: AppSpacing.largeSpace),

              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: AppStrings.descriptionOptional, border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: AppSpacing.xLargeSpace),

              AppButton(
                text: AppStrings.confirmSale,
                onTap: () {
                  if (authState is AuthLogin) {
                    FirestoreService().setOrderValue(userId: authState.user.uid, product: widget.productModel, region: selectedRegion?.name ?? "", count: widget.count, docs: noteController.text).then((value){
                      NavigatorService.pop();
                    });
                  }
                },
              ),

              const SizedBox(height: AppSpacing.mediumSpace),
            ],
          ),
        ),
      ),
    );
  }
}
