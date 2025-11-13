import 'package:carousel_slider/carousel_slider.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/app/app_spacing.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:demomanager/core/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../core/services/navigator_service/navigator_service.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            NavigatorService.pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(args.name, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (args.images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(height: 220, enlargeCenterPage: true, enableInfiniteScroll: true, autoPlay: true),
                items: args.images.map((img) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(img, width: double.infinity, fit: BoxFit.cover),
                  );
                }).toList(),
              )
            else
              Container(
                height: 220,
                decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.image, size: 80, color: theme.colorScheme.primary),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(AppStrings.description, theme),
                Text(args.description, style: theme.textTheme.bodyMedium),
              ],
            ).withGap(AppSpacing.smallSpace),
            if (args.attributes.contents.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_sectionTitle(AppStrings.contents, theme), ...List.generate(args.attributes.contents.length, (i) => Text("• ${args.attributes.contents[i]}"))],
              ).withGap(AppSpacing.smallSpace),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_sectionTitle(AppStrings.usage, theme), Text(args.attributes.usage)]).withGap(AppSpacing.smallSpace),
            if (args.attributes.suitableFor.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(AppStrings.suitableFor, theme),
                  Wrap(
                    spacing: 8,
                    children: List.generate(args.attributes.suitableFor.length, (i) => Chip(label: Text(args.attributes.suitableFor[i]), backgroundColor: theme.colorScheme.primary.withOpacity(.1))),
                  ),
                ],
              ).withGap(AppSpacing.smallSpace),
          ],
        ).withGap(AppSpacing.defaultSpace),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary),
            onPressed: () {},
            child: Text("${args.price.toStringAsFixed(2)} ${args.currency}", style: TextStyle(color: theme.colorScheme.onPrimary)),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 10),
          Text(text, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
