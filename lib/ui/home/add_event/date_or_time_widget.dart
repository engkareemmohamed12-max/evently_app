import 'package:flutter/material.dart';

import '../../../main.dart';

class DateOrTimeItemWidget extends StatelessWidget {
  final dateOrTimeIcon;
  final String eventDateOrTime;
  final String chooseDateOrTime;
  VoidCallback onChooseDateorTime;
   DateOrTimeItemWidget({super.key ,
    required this.dateOrTimeIcon ,
    required this.eventDateOrTime ,
    required this.onChooseDateorTime,
    required this.chooseDateOrTime
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Row(
      spacing: width*0.04,
      children: [

        dateOrTimeIcon,
        Text(eventDateOrTime , style: Theme.of(context).textTheme.headlineMedium,),
        Spacer(),
        TextButton(onPressed: onChooseDateorTime,
            child: Text(chooseDateOrTime , style: Theme.of(context).textTheme.labelLarge?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).cardColor,
            ),)
        ),
      ],
    );
  }
}
