import 'package:flutter/material.dart';


class NextButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap ;
  final bool loading ;
  const NextButton({Key? key ,
    required this.title,
    required this.onTap,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xff2980B9),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
        Text(title, style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}