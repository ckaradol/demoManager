import 'package:demomanager/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categories_bloc/categories_bloc.dart';
import '../enums/app/app_spacing.dart';
import '../helper/category_avatar.dart';

class AppCategories extends StatelessWidget {
  const AppCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc()..add(CategoriesInitialEvent()),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return SizedBox(
            height: 150,
            child: ListView(
              padding: EdgeInsets.all(AppSpacing.defaultSpace),
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: (){
                    context.read<ProductBloc>().add(ProductInitialEvent());
                  },
                  child: Card(
                    margin:const EdgeInsets.symmetric(horizontal: AppSpacing.smallSpace) ,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      width: 95,
                      padding: EdgeInsets.all(AppSpacing.mediumSpace),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [Theme.of(context).colorScheme.inversePrimary, Theme.of(context).colorScheme.primary]),
                              boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), blurRadius: 6)],
                            ),
                            child: Center(
                              child: Text(
                                categoryAvatar("Tümü"),
                                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Spacer(),

                          Text(
                            "Tümü",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                if(state is CategoriesLoad)
                for(var data in state.categories)
                InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: (){
                    context.read<ProductBloc>().add(ProductInitialEvent(catId: data.docId));
                  },
                  child: Card(
                    margin:const EdgeInsets.symmetric(horizontal: AppSpacing.smallSpace) ,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      width: 95,
                      padding: EdgeInsets.all(AppSpacing.mediumSpace),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [Theme.of(context).colorScheme.inversePrimary, Theme.of(context).colorScheme.primary]),
                              boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), blurRadius: 6)],
                            ),
                            child: Center(
                              child: Text(
                                categoryAvatar(data.name),
                                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Spacer(),

                          Text(
                            data.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
          );
        },
      ),
    );
  }
}
