import 'package:flutter/material.dart';
import 'package:login_flutter/global_components/widgets/widgets.dart';
import 'package:login_flutter/ui/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final CustomWidgets _widgets = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 150),
            TextFormField(
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  label: const Text("Username"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
            const SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  label: const Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
              _widgets.snackBar(context: context, isError: false, text: 'Login Successful');
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OTPScreen()),
                  );
                });
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
