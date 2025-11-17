import 'package:carousel_slider/carousel_slider.dart';
import 'package:demomanager/core/constants/app_strings.dart';
import 'package:demomanager/core/enums/app/app_spacing.dart';
import 'package:demomanager/core/extensions/app/app_column_gap_ext.dart';
import 'package:demomanager/core/models/product_model.dart';
import 'package:demomanager/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../core/helper/locations.dart';
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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => SalesModalBottom(productModel: args),
              );
            },
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

class SalesModalBottom extends StatefulWidget {
  final ProductModel productModel;

  const SalesModalBottom({super.key, required this.productModel});

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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultSpace),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),

                  Text("Satış Oluştur", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "İl Seçin", border: OutlineInputBorder()),
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
                  const SizedBox(height: 15),

                  if (selectedRegion != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.surfaceContainerHighest),
                      child: Text("Bölge: ${selectedRegion.toString().split('.').last}", style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  const SizedBox(height: 15),

                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(labelText: "Açıklama (Opsiyonel)", border: OutlineInputBorder()),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 30),

                  AppButton(
                    text: "Onayla",
                    onTap: () {

                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
