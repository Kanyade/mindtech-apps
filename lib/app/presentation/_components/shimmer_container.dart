import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key, required this.height, required this.width, required this.radius});

  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(colors: [AppColors.gray85, AppColors.gray65]),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
