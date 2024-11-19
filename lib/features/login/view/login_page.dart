import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/features/login/bloc/login_bloc.dart';
import 'package:ui/generated/l10n.dart';
import 'package:ui/injector/injector.dart';
import 'package:ui/router/app_router.dart';
import 'package:ui/widgets/loading_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => Injector.instance<LoginBloc>(),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(S.current.login),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (prev, next) => prev.loading != next.loading,
        listener: (context, state) {
          state.notification?.when(
            insertSuccess: (message) {
              Flushbar(
                message: message,
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.green,
              ).show(context);
              context.push(AppRouter.homePath);
            },
            insertFailed: (message) {
              Flushbar(
                message: message,
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.red,
              ).show(context);
            },
          );
        },
        builder: (context, state) {
          return Stack(
            children: [
              _buildLoginForm(context, state.username, state.password),
              if (state.loading) const LoadingPage(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginForm(
      BuildContext context, String username, String password) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: S.current.username),
              initialValue: username,
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEvent.changeUsername(value));
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: S.current.password),
              obscureText: true,
              initialValue: password,
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginEvent.changePassword(value));
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(const LoginEvent.login());
                },
                child: Text(S.current.login))
          ],
        ),
      ),
    );
  }
}
