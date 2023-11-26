import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Ingrese un PIN'),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                PinCodeTextField(
                  controller: controller,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Por favor ingresa un pin de 6 digitos';
                    } else if (value.isEmpty) {
                      return 'Por favor ingresa un pin valido';
                    }
                    return null;
                  },
                ),
                FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String value = controller.text;
                        Navigator.of(context).pop(value);
                      }
                    },
                    child: const Text('Guardar'))
              ],
            )),
      )),
    );
  }
}
