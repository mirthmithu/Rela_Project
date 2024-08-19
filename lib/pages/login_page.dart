import 'package:flutter/material.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/pages/session.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      final formattedDate =
          '${picked.year}-${picked.month}-${picked.day}'; // Format the picked date
      dobController.text =
          formattedDate; // Update text field with formatted date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 26,
                  ),
                ),

                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.login,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back to rela!!!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 26,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Employee Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Employee ID',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // Date of Birth textfield with calendar picker
                MyTextField(
                  controller: dobController,
                  hintText: 'Date of Birth',
                  obscureText: false,
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        _selectDate(context), // Show date picker on tap
                    child: const AbsorbPointer(
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 10),

                // forgot password?
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),

                const SizedBox(height: 50),

                // sign in button

                MyButton(
                  onTap: () {
                    // Navigate to another page here
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons

                const SizedBox(height: 50),

                // not a member? register now
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
