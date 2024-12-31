import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneul/communities/community_main.dart';
import 'package:oneul/meetings/meeting_main.dart';
import 'package:oneul/signins/signins.dart';
import 'package:oneul/test/test.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(path: '/', name:'home', builder:(context, state) => SigninPage()),
    GoRoute(path: '/meeting', name:'meeting', builder:(context, state) => MeetingMainPage()),
    GoRoute(path: '/community', name:'community', builder:(context, state) => CommunityMainPage()),
    GoRoute(path: '/test', name: 'counter', builder:(context, state) => TestPage())
  ]);
}