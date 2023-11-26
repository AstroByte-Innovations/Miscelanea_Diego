import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: const Column(children: [
                _UserView(),
              ]),
            ))
          ],
        ));
  }
}

class _Singin extends StatefulWidget {
  const _Singin();

  @override
  State<_Singin> createState() => _SinginState();
}

class _SinginState extends State<_Singin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Usuario'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Contraseña'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 50),
            FilledButton(
              onPressed: () {},
              child: const Text('Ingresar'),
            ),
          ],
        ));
  }
}

class _UserView extends StatelessWidget {
  const _UserView();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.person),
        label: const Text('User 1'));
  }
}
