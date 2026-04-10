import 'package:evently_app/ui/utils/app_color.dart';
import 'package:flutter/material.dart';


typedef OnChanged = void Function(String)? ;
typedef OnValidator = String? Function(String?)? ;

class CustomTextField extends StatelessWidget {
  final Color? cursorColor ;
  final String? hintText ;
  final TextStyle? hintStyle ;
  final String? labelText ;
  final TextStyle? labelStyle ;
  final TextStyle? style ;
  final Widget? prefixIcons;
  final Widget? suffixIcons;
   OnChanged onChanged ;
   TextEditingController? controller;
   int? maxLines;
   OnValidator validator ;
   final bool obscureText;
   TextInputType keyboardType ;
   CustomTextField({super.key ,  this.cursorColor , this.hintText , this.hintStyle , this.labelText , this.labelStyle ,
    this.style , this.prefixIcons , this.suffixIcons , this.onChanged , this.controller , this.maxLines ,
     this.validator , this.obscureText = false , this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        style: Theme.of(context).textTheme.headlineMedium,
        decoration: InputDecoration(
            enabledBorder: _builtDecorationBorder(radius: 16,
                borderColor: Theme.of(context).dividerColor),


            focusedBorder : _builtDecorationBorder(radius: 16,
                borderColor: Theme.of(context).dividerColor),

          
          errorBorder: _builtDecorationBorder(radius: 16,
              borderColor: AppColors.redColor),


          focusedErrorBorder: _builtDecorationBorder(radius: 16,
              borderColor: AppColors.redColor),

          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: labelStyle,

          prefixIcon: prefixIcons,
          suffixIcon: suffixIcons,


        ),
      onChanged: onChanged,
      controller: controller,
      validator: validator,

    );
  }

  OutlineInputBorder _builtDecorationBorder({required double radius , required Color borderColor}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
          color: borderColor,
          width: 2
      ),
    );
  }
}
