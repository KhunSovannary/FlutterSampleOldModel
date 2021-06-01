import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/forget_password_repository.dart';
import 'package:flutter_chabhuoy/screens/login_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_textfield_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({@required this.phone});

  final String phone;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final App myApp = App();
  final ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository();

  TextEditingController textNewPassword = TextEditingController();
  TextEditingController textConfirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textNewPassword.dispose();
    textConfirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: App.iconsThem,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Please enter new password.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              CustomTextFieldWidget(
                  title: 'New Password',
                  iconData: Icons.lock,
                  obscureText: true,
                  numberOnly: false,
                  textEditingController: textNewPassword),
              CustomTextFieldWidget(
                  title: 'Confirm New Password',
                  iconData: Icons.lock,
                  obscureText: true,
                  numberOnly: false,
                  textEditingController: textConfirmPassword),
              CustomButtonWidget(
                  title: 'Reset',
                  function: () {
                    if (textNewPassword.text != '' &&
                        (textNewPassword.text == textConfirmPassword.text)) {
                      myApp.showLoading(context);

                      forgetPasswordRepository
                          .resetPassword(
                              phone: widget.phone,
                              password: textNewPassword.text)
                          .then((response) => {
                                print(response.httpCode),
                                if (!response.status)
                                  {
                                    myApp.showMessageDialog(
                                        context: context, message: response.msg)
                                  }
                                else
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    )
                                  }
                              });
                    } else {
                      myApp.showMessageDialog(
                          context: context,
                          message: 'Please enter password.',
                          icon: Icons.warning);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
