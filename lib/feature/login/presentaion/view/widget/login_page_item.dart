import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/widget/widget/logo_with_shimer.dart';

import '../../../../../core/widget/widget/custom_button.dart';
import '../../../../../core/widget/widget/custom_text_field.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginPageItem extends StatefulWidget {
  const LoginPageItem({super.key});

  @override
  State<LoginPageItem> createState() => _LoginPageItemState();
}

class _LoginPageItemState extends State<LoginPageItem> {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 60),
              LogoWithAnimatedText(),
              const SizedBox(height: 100),
              CustomTextField(
                label: LangKeys.phoneNumber.tr(),
                hint: LangKeys.phoneNumber.tr(),
                controller: numberController,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                label: LangKeys.password.tr(),
                hint: LangKeys.password.tr(),
                controller: passwordController,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: LangKeys.login.tr(),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(context).loginUser(
                      number: numberController.text.trim(),
                      pass: passwordController.text.trim(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // زر تغيير اللغة هنا
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Tooltip(
                      message: context.locale.languageCode == 'en'
                          ? 'Change Language'
                          : 'تغيير اللغة',
                      child: IconButton(
                        icon: Icon(
                          Icons.language,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          final newLocale = context.locale.languageCode == 'en'
                              ? const Locale('ar', 'EG')
                              : const Locale('en', 'US');
                          context.setLocale(newLocale);
                        },
                      ),
                    ),
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
