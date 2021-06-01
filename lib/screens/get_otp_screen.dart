import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/otp_code_repository.dart';
import 'package:flutter_chabhuoy/screens/reset_password_screen.dart';
import 'package:flutter_chabhuoy/screens/root_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/text_opt_widget.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen(
      {@required this.phone,
      @required this.fullName,
      @required this.password,
      @required this.requestId});

  final String phone, fullName, password, requestId;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final OtpCodeRepository optCodeRepository = OtpCodeRepository();

  TextEditingController pin1TextEditController = TextEditingController();
  TextEditingController pin2TextEditController = TextEditingController();
  TextEditingController pin3TextEditController = TextEditingController();
  TextEditingController pin4TextEditController = TextEditingController();

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  String code = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();

    pin1TextEditController.dispose();
    pin2TextEditController.dispose();
    pin3TextEditController.dispose();
    pin4TextEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: App.iconsThem,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                child: Image.asset(
                  'images/ic_sms_phone.png',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'PLEASE ENTER',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'THE VALIDATION CODE YOU JUST RECEIVED',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextOPTWidget(
                    textEditingController: pin1TextEditController,
                    onChanged: (val) => {
                      if (val.length > 0) {pin2FocusNode.requestFocus()}
                    },
                    autFocus: true,
                  ),
                  TextOPTWidget(
                    textEditingController: pin2TextEditController,
                    onChanged: (val) => {
                      if (val.length > 0) {pin3FocusNode.requestFocus()}
                    },
                    autFocus: false,
                    focusNode: pin2FocusNode,
                  ),
                  TextOPTWidget(
                    textEditingController: pin3TextEditController,
                    onChanged: (val) => {
                      if (val.length > 0) {pin4FocusNode.requestFocus()}
                    },
                    autFocus: false,
                    focusNode: pin3FocusNode,
                  ),
                  TextOPTWidget(
                    textEditingController: pin4TextEditController,
                    onChanged: (val) => {
                      if (val.length > 0) {pin4FocusNode.unfocus()}
                    },
                    autFocus: false,
                    focusNode: pin4FocusNode,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                  title: 'Verify',
                  function: () => {
                        code = pin1TextEditController.text +
                            pin2TextEditController.text +
                            pin3TextEditController.text +
                            pin4TextEditController.text,
                        if (widget.fullName == null)
                          {
                            optCodeRepository
                                .verifyOtpForgetPassword(
                                    verifyCode: code,
                                    requestId: widget.requestId)
                                .then((response) => {
                                      if (!response.status)
                                        {}
                                      else
                                        {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordScreen(
                                                        phone: widget.phone)),
                                          )
                                        }
                                    })
                          }
                      }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do not get code'),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'RESEND?',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
