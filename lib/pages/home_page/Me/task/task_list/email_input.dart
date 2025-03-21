import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/generated/l10n.dart';

class EmailInput extends StatefulWidget {
  final TextEditingController emailController;
  const EmailInput({super.key, required this.emailController});

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  String _validationMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((st) {
      validate(widget.emailController.text);
    });
  }

  void validate(value) {
    if (value == "" || value == null) {
      _validationMessage = '';
    } else if (EmailValidator.validate(value)) {
      _validationMessage = '';
    } else {
      _validationMessage = S.of(context).email_format_error;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.emailController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'email', // 输入框标签
            hintText: S.of(context).please_enter_your_email, // 提示文本
            border: OutlineInputBorder(), // 边框样式
          ),
          onChanged: (value) {
            // 监听输入变化
            validate(value);
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          _validationMessage,
          style: TextStyle(
            color:
                _validationMessage.contains('正确') ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
