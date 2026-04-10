import 'package:flutter/material.dart';

class DialogUtils {


  static void showLoading({required BuildContext context , required loadindMessage}){



    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(

          content: Row(
            spacing: 15,
            children: [

              CircularProgressIndicator(

                color: Theme.of(context).cardColor,
              ),
              Text(loadindMessage ,

              style: Theme.of(context).textTheme.headlineLarge,
              ),

            ],
          ),
        ),
    );

  }

  static void hideLoading({required BuildContext context}){

    Navigator.pop(context);

  }

  static void showMessage({required BuildContext context ,
    required String message ,
    String? title ,
    String? postName
  , VoidCallback? postAction,
    String? negActionName ,
    VoidCallback? negAction,
  }){


    List<Widget> actions = [];

    if(postName != null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            if(postAction != null){
              postAction?.call();
            }
          },
          child: Text(postName , style: Theme.of(context).textTheme.headlineSmall,)
      ));
    }


    if(negActionName != null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            if(negAction != null){
              negAction?.call();
            }
          },
          child: Text(negActionName , style: Theme.of(context).textTheme.headlineSmall,)
      ));
    }

    showDialog(context: context, 
        builder: (context) => AlertDialog(

          content: Text(message , style: Theme.of(context).textTheme.headlineLarge,),

          title: Text(title ?? '' , style: Theme.of(context).textTheme.headlineMedium,),

          actions: actions,
          
        ),
    );

  }


}