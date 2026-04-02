import 'package:evently_app/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget? child ;
  final Color? backgroundColor ;
  final double? radius ;
  final Color? borderColor ;
  final double? horizontalPadding ;
  final double? verticalPadding ;
  const CustomElevatedButton({super.key , required this.onPressed , required this.child
  , this.backgroundColor , this.radius , this.borderColor , this.horizontalPadding , this.verticalPadding ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical:verticalPadding ?? 0
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radius ?? 16),
          side: BorderSide(
            width: 2 ,
            color: borderColor ?? AppColors.transparentColor
          ),
        ),

      ),
      
      onPressed: onPressed,
        child: child ,
    );
  }
}
