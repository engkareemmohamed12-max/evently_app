import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_route.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/utils/dialog_utils.dart';
import 'package:evently_app/ui/widget/custom_elevated_button.dart';
import 'package:evently_app/ui/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../utils/toast_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isPasswordHidden = true;

  var emailController = TextEditingController(text: "kareem@route.com");
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();



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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                
                  spacing: height*0.02,
                  children: [
                
                    Image.asset(
                
                      themeProvider.isDark ?
                          AppAssets.logodark:
                        AppAssets.logolight),
                
                    Text(AppLocalizations.of(context)!.login_to_your_account ,
                
                      style: Theme.of(context).textTheme.headlineSmall,
                
                    ),
                
                    //Email//
                    CustomTextField(
                      cursorColor: Theme.of(context).cardColor,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppLocalizations.of(context)!.enter_your_email,
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      validator: (text) {

                        if(text == null || text.trim().isEmpty ){

                          return 'Please Enter Email';

                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);

                        if(!emailValid){
                          return 'please Enter Valid Email';

                        }

                        return null;

                      },
                      controller: emailController,
                      prefixIcons: Icon(Icons.email_outlined , color: AppColors.disableColor,),
                
                    ),
                
                    //Password//
                    CustomTextField(
                      cursorColor: Theme.of(context).cardColor,
                      keyboardType: TextInputType.number,
                      hintText: AppLocalizations.of(context)!.enter_your_password,
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcons: Icon(Icons.lock_open_outlined, color: AppColors.disableColor),

                      controller: passwordController,

                      validator: (text) {
                        if(text == null || text.trim().isEmpty){

                          return 'Please Enter Password';
                        }
                        if(text.length < 6){

                          return ' Password Should be at least 6 chars';

                        }

                        return null ;
                      },
                
                      obscureText: isPasswordHidden,
                
                      suffixIcons: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.disableColor,
                        ),
                      ),
                    ),
                
                
                
                        //Forget Password//
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                
                              //todo: navigate to forget password
                
                            }, child:
                
                            Text(
                
                              '${AppLocalizations.of(context)!.forget_password}',
                
                              style: Theme.
                              of(context)
                                  .textTheme
                                  .labelLarge?.copyWith(
                
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).cardColor
                
                              ),
                            ),
                            ),
                          ],
                        ),
                
                    //ElevationButton//
                    CustomElevatedButton(
                      onPressed: login ,
                        backgroundColor: Theme.of(context).cardColor,
                      verticalPadding: height*0.01,
                        child: Text(AppLocalizations.of(context)!.login ,
                        style: AppStyle.medium20White,
                        ),
                
                    ),
                
                
                
                
                    // Sign UP //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.dontHaveAnAccount,
                        style:  Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context, AppRoute.registerRouteName);
                          }, child:
                        Text(AppLocalizations.of(context)!.sign_up,
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
                
                      loginWithGoogle();
                
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
                            Text(AppLocalizations.of(context)!.login_google ,
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
      ),
    );
  }

  void login() async{
    if(formKey.currentState?.validate() == true){

      //todo : login
      // todo : show loading

      DialogUtils.showLoading(context: context, loadindMessage: 'Loading...');

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        // todo : hide loading
        DialogUtils.hideLoading(context: context);

        //todo :show message
        DialogUtils.showMessage(
            context: context,
            message: 'Login Successfully' , title: 'Success' , postName: "Ok" , postAction: (){
              Navigator.of(context).pushReplacementNamed(AppRoute.homeRouteName);
        }
        );


      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          // todo : hide loading
          DialogUtils.hideLoading(context: context);
          //todo :show message
          DialogUtils.showMessage(
              context: context,
              message: 'No user found for that email or password.' , title: 'Error' , postName: "Ok");

        } else if (e.code == 'wrong-password') {

          DialogUtils.showMessage(
              context: context,
              message: 'wrong-password' ,
              title: 'Error' , postName: "Ok"
          );        }
      }catch(e){
        // todo : hide loading
        DialogUtils.hideLoading(context: context);
        //todo :show message
        DialogUtils.showMessage(context: context, message: e.toString() , title: 'Error' , postName: "Ok");
        print(e);
      }

    }
  }

  void loginWithGoogle() async {
    try {
      DialogUtils.showLoading(context: context, loadindMessage: 'Loading...');

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId:
        "139272232990-utbale4sjsaih5ftbhct5gmce8er9a40.apps.googleusercontent.com",
      );

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        //accessToken: googleAuth.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      DialogUtils.hideLoading(context: context);

      if (!mounted) return;

      Navigator.of(context)
          .pushReplacementNamed(AppRoute.homeRouteName);

    } catch (e) {
      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: 'Error',
        postName: "Ok",
      );
    }
  }}
