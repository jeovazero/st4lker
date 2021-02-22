import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';

final String avatarImg =
    'https://avatars.githubusercontent.com/u/11683201?s=400&'
    'u=fcb64bc60fe3c6712585f6faec3e68573a86f201&v=4';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0, 0.6],
          colors: [grad1, grad2],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 40,
          bottom: 56,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatarImg),
                  radius: 28,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'jeovazero',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontFamily: 'Tuffy',
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  children: [
                    Text(
                      '50 repositories',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Tuffy',
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.white,
                    ),
                    Text(
                      '650 stars',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Tuffy',
                      ),
                    )
                  ],
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
