import 'package:flutter/material.dart';
import 'package:real_world_provider/core/theme/app_colors.dart';
import 'package:real_world_provider/core/theme/app_typography.dart';


class ProductPreviewSection extends StatelessWidget {
  const ProductPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          _ProductBackground(),
          SafeArea(child: _Content()),
        ],
      ),
    );
  }
}

class _ProductBackground extends StatelessWidget {
  const _ProductBackground();

  @override
  Widget build(BuildContext context, ) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.secondarySurface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActionBar(headline: 'Mr. Cheezy',),
          SizedBox(height: 20,),
          Row(
            children: [
              Spacer(),
              Image.asset(
                'assets/images/hamburger.png', // Asegúrate de tener esta imagen
                height: 256,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  // Placeholder si no se encuentra la imagen
                  return Container(
                    height: 256,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  final String headline;
  const _ActionBar({required this.headline,});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          headline,
          style: appTypography.headLine.copyWith(color: colors.onSecondarySurface),
        ),
        const _CloseButton(),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colors.actionSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            color: colors.secondarySurface,
            size: 24,
          ),
        ),
      ),
    );
  }
}
