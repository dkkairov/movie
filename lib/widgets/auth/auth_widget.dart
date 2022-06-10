import 'package:flutter/material.dart';
import 'package:movie/theme/app_button_style.dart';
import 'package:movie/widgets/auth/auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          const _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
          fontSize: 16,
          color: Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          _FormWidget(),
          const SizedBox(height: 20,),
          const Text(
            'Войти в свою учётную запись',
            style: textStyle,
          ),
          const SizedBox(height: 10,),
          const Text(
            'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, '
              'необходимо войти в свою учётную запись. Если у вас нет учётной записи, '
              'её регистрация является бесплатной и простой. Кликни сюда.',
            style: textStyle,
          ),
          const SizedBox(height: 10,),
          const Text(
            'Если Вы зарегистрировались, но не получили письмо для подтверждения.',
            style: textStyle,
          ),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Register')
          ),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Verify email')
          ),
        ],
      ),
    );
  }
}


class _FormWidget extends StatelessWidget {
  _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.blueAccent,
    );
    const inputStyle = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessagesWidget(),
        const Text('Username', style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model?.loginTextController,
          decoration: inputStyle,
        ),
        const SizedBox(height: 10,),
        const Text('Password', style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model?.passwordTextController,
          decoration: inputStyle,
          obscureText: true,
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            AuthButtonWidget(model: model,),
            const SizedBox(width: 25,),
            TextButton(
                onPressed: () {},
                style: AppButtonStyle.linkButton,
                child: const Text('Forgot password?')),
          ],
        ),
      ],
    );
  }
}



class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AuthModel? model;

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed = model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true ? SizedBox(
      child: const CircularProgressIndicator(
        strokeWidth: 2,
      ),
      width: 15,
      height: 15,
    ) : const Text('Login');
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
    );
  }
}



class _ErrorMessagesWidget extends StatelessWidget {
  const _ErrorMessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if(errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}



