import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/product_bloc/product_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../core/enums/app/app_spacing.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/firebase_auth_service/firebase_auth_service.dart';
import '../../core/services/navigator_service/navigator_service.dart';
import '../../core/widgets/app_categories.dart';
import '../../core/widgets/app_text_form_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuthService().signOut();
            },
            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(AppStrings.home, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
      body: BlocProvider(
        create: (context) => ProductBloc()..add(ProductInitialEvent()),

        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.only(top: AppSpacing.mediumSpace),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.defaultSpace),
                  child: AppTextFormField(
                    controller: null,
                    labelText: AppStrings.search,
                    onChange: (value) {
                      context.read<ProductBloc>().add(ProductInitialEvent(filter: value));
                    },
                  ),
                ),
                AppCategories(),
                GridView(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.defaultSpace),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: AppSpacing.mediumSpace, mainAxisSpacing: AppSpacing.mediumSpace),
                  children: [
                    if (state is ProductLoad)
                      for (var data in state.products)
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: (){
                            NavigatorService.pushNamed(AppRoutes.productDetail,arguments: data);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppSpacing.mediumSpace, vertical: AppSpacing.mediumSpace),
                              child: Column(
                                children: [
                                  if (data.images.isNotEmpty)
                                    Expanded(
                                      child: Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(image: NetworkImage(data.images.first), fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  else
                                    Expanded(child: SizedBox()),
                                  Text(data.name, textAlign: TextAlign.center,maxLines: 2,),
                                ],
                              ).withGap(AppSpacing.mediumSpace),
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
