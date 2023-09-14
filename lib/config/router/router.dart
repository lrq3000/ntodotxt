import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ntodotxt/domain/todo/todo_model.dart';
import 'package:ntodotxt/presentation/layout/adaptive_layout.dart';
import 'package:ntodotxt/presentation/login/pages/login_page.dart';
import 'package:ntodotxt/presentation/login/states/login.dart';
import 'package:ntodotxt/presentation/settings/pages/settings_page.dart';
import 'package:ntodotxt/presentation/todo/pages/todo_create_page.dart';
import 'package:ntodotxt/presentation/todo/pages/todo_edit_page.dart';
import 'package:ntodotxt/presentation/todo/pages/todo_list_page.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  final LoginCubit loginCubit;

  AppRouter(this.loginCubit);

  late final GoRouter routerNarrowLayout = GoRouter(
    initialLocation: '/todo',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPage();
        },
      ),
      GoRoute(
        path: '/todo',
        name: 'todo-list',
        builder: (BuildContext context, GoRouterState state) {
          return const NarrowLayout(
            child: TodoListPage(),
          );
        },
        routes: [
          GoRoute(
            path: 'todo/create',
            name: 'todo-create',
            builder: (BuildContext context, GoRouterState state) {
              return const NarrowLayout(
                child: TodoCreatePage(),
              );
            },
          ),
          GoRoute(
            path: 'todo/edit',
            name: 'todo-edit',
            builder: (BuildContext context, GoRouterState state) {
              Todo todo = state.extra as Todo;
              return NarrowLayout(
                child: TodoEditPage(todo: todo),
              );
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final AuthStatus authState = context.read<LoginCubit>().state.status;
      final bool onLoginPage = state.fullPath == '/login';
      if (authState != AuthStatus.authenticated) {
        return onLoginPage ? null : '/login';
      }
      if (onLoginPage) {
        return '/todo';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(loginCubit.stream),
  );

  late final GoRouter routerWideLayout = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/todo',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return WideLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsPage();
            },
          ),
          GoRoute(
            path: '/todo',
            name: 'todo-list',
            builder: (BuildContext context, GoRouterState state) {
              return const TodoListPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'todo/create',
                name: 'todo-create',
                builder: (BuildContext context, GoRouterState state) {
                  return const TodoCreatePage();
                },
              ),
              GoRoute(
                path: 'todo/edit',
                name: 'todo-edit',
                builder: (BuildContext context, GoRouterState state) {
                  Todo todo = state.extra as Todo;
                  return TodoEditPage(todo: todo);
                },
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final AuthStatus authState = context.read<LoginCubit>().state.status;
      final bool onLoginPage = state.fullPath == '/login';
      if (authState != AuthStatus.authenticated) {
        return onLoginPage ? null : '/login';
      }
      if (onLoginPage) {
        return '/todo';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(loginCubit.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
