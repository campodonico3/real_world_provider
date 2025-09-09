import 'package:flutter/material.dart';
import 'package:real_world_provider/core/theme/app_colors.dart';
import 'package:real_world_provider/widgets/product_preview_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          ProductPreviewSection(),
        ],
      ),
    );
  }
}
