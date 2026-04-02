import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_route.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/widget/custom_elevated_button.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var Width = context.width;
    var height = context.height;
    var  themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: Width*0.04,
                  vertical: height*0.02,
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
        
                spacing: height*0.02,
                children: [
                  
                  Image.asset(
        
                    themeProvider.isDark ?
                        AppAssets.logodark:
                      AppAssets.logolight),
        
                  Text(AppLocalizations.of(context)!.create_account ,
        
                    style: Theme.of(context).textTheme.headlineSmall,
        
                  ),


                  //Name//
                  CustomTextField(
                    cursorColor: Theme.of(context).cardColor,
                    hintText: AppLocalizations.of(context)!.name,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcons: Icon(Icons.person_outline , color: AppColors.disableColor,),

                  ),
        
                  //Email//
                  CustomTextField(
                    cursorColor: Theme.of(context).cardColor,
                    hintText: AppLocalizations.of(context)!.enter_your_email,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcons: Icon(Icons.email_outlined , color: AppColors.disableColor,),
        
                  ),
        
                  //Password//
                  CustomTextField(cursorColor: Theme.of(context).cardColor ,
                    hintText: AppLocalizations.of(context)!.enter_your_password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcons: Icon(Icons.lock_open_outlined , color: AppColors.disableColor,),
                    suffixIcons: Icon(Icons.visibility_off_outlined , color: AppColors.disableColor,),
        
                  ),


                      //Confirm Password//
                  //Password//
                  CustomTextField(cursorColor: Theme.of(context).cardColor ,
                    hintText: AppLocalizations.of(context)!.confirm_password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcons: Icon(Icons.lock_open_outlined , color: AppColors.disableColor,),
                    suffixIcons: Icon(Icons.visibility_off_outlined , color: AppColors.disableColor,),

                  ),
                  
        

                  SizedBox(height: height*0.01,),

        
                  //ElevationButton//
                  CustomElevatedButton(onPressed: (){
                    //todo : register
                  },
                      backgroundColor: Theme.of(context).cardColor,
                    verticalPadding: height*0.01,
                      child: Text(AppLocalizations.of(context)!.sign_up ,
                      style: AppStyle.medium20White,
                      ),
        
                  ),
        
        
                  // Login //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.already_have_an_account,
                      style:  Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(onPressed: (){
                        //todo : navigate to login screen
                        Navigator.pushReplacementNamed(context, AppRoute.loginRouteName);
                      }, child:
                      Text(AppLocalizations.of(context)!.login,
                        style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).cardColor
                        ),
                      ),
                      ),
                    ],
                  ),
                  
                  //OR//
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          endIndent: Width*0.06,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.or ,
                      style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          indent: Width*0.06,
                        ),
                      ),
        
                    ],
                  ),

                  //Google Login//
                  CustomElevatedButton(onPressed: (){

                    //todo : sign up with google

                  },
                    backgroundColor: AppColors.transparentColor,
                    borderColor: Theme.of(context).dividerColor,
                    verticalPadding: height*0.02,
                      child:
                      Row(
                        spacing: Width*0.04,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.google),
                          Text(AppLocalizations.of(context)!.sign_google ,
                          style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                  ),
        
        
        
                ],
              ),
        
            ),
        ),
      ),
    );
  }
}
