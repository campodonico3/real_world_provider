import 'package:flutter/material.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 12),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      height: 88,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFF2),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          SizedBox(width: 12,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome back, Kevin!'),
              Text('How Hungry are you?'),
            ],
          ),
        ],
      ),
    );
  }
}
