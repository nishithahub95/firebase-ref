

import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String option;

final Color color;

final VoidCallback onTap;


 OptionCard({Key? key,required this.option,required this.color,required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color,
        child: ListTile(
          title: Text(option,textAlign:TextAlign.center,style: TextStyle(
            fontSize: 20
          ),),
        ),
      ),
    );
  }
}
