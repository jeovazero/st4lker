import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_events_search/github_events_search.dart';

import 'colors.dart';

class UserSliver extends SliverPersistentHeaderDelegate {
  final GithubUser user;

  UserSliver(this.user);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var followers = user.followers;
    var avatarUrl = user.avatar_url;
    var name = user.name ?? user.login;
    var repos = user.public_repos;

    return LayoutBuilder(builder: (context, constraints) {
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

      return Container(
        alignment: Alignment.center,
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.lerp(Colors.blue, Colors.red, percentage)
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              top: 8,
              left: 24,
              right: 18,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                      radius: lerpDouble(20, 32, percentage),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(width: 24),
                Flexible(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: lerpDouble(24, 36, percentage),
                        color: Colors.white,
                        fontFamily: 'Tuffy',
                      ),
                    ),
                    SizedBox(height: 16),
                    if (percentage > 0.55)
                      Wrap(
                        children: [
                          Text(
                            '${repos} repositor${repos > 0 ? 'ies' : 'y'}',
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
                            '${followers} follower${followers > 0 ? 's' : ''}',
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
                )),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 80.0;
}
