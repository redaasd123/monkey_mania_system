import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';
import 'package:monkey_app/core/widget/widget/bottom_sheet_button.dart';
import 'package:monkey_app/feature/users/domain/entity/user_data_entity.dart';
import 'package:monkey_app/feature/users/domain/repo/create_user_param.dart';

import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';

Future<CreateUserParam?> showUserBottomSheet(
  BuildContext context,
  String title,
  bool isCreate, {
  UserDataEntity? data,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) =>
        UserBottomSheet(title: title, data: data, isCreate: isCreate),
  );
}

class UserBottomSheet extends StatefulWidget {
  const UserBottomSheet({
    super.key,
    required this.title,
    this.data,
    required this.isCreate,
  });

  final String title;
  final UserDataEntity? data;
  final bool isCreate;

  @override
  State<UserBottomSheet> createState() => _UserBottomSheetState();
}

class _UserBottomSheetState extends State<UserBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  String selectRole = 'waiter';
  final List<String> options = [
    'waiter',
    'owner',
    'admin',
    'reception',
    'manager',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      final user = widget.data!;
      nameCtrl.text = user.name ?? '';
      phoneCtrl.text = user.phoneNumber ?? '';
      emailCtrl.text = user.email ?? '';
      selectRole = user.role;
      if (!options.contains(selectRole)) {
        options.add(selectRole);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: MediaQuery.removeViewInsets(
        removeBottom: true,
        context: context,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHandle(),
                  const SizedBox(height: 8),
                  _buildHeader(colorScheme),
                  const SizedBox(height: 20),
                  _buildForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() => Center(
    child: Container(
      width: 48,
      height: 4,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(kTest),
        ),
        const SizedBox(width: 12),
        Text(
          LangKeys.appName.tr(),
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildField(
              nameCtrl,
              TextInputType.name,
              LangKeys.name.tr(),
              Icons.person,
            ),
            const SizedBox(height: 12),
            _buildField(
              passCtrl,
              TextInputType.visiblePassword,
              LangKeys.password.tr(),
              Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 12),
            _buildField(
              confirmPassCtrl,
              TextInputType.visiblePassword,
              LangKeys.confirmPass.tr(),
              Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 12),
            _buildField(
              phoneCtrl,
              TextInputType.phone,
              LangKeys.phoneNumber.tr(),
              Icons.phone,
            ),
            const SizedBox(height: 12),
            _buildField(
              emailCtrl,
              TextInputType.emailAddress,
              LangKeys.email.tr(),
              Icons.email,
              isRequired: false,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectRole,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: "Select Role",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
              dropdownColor: colorScheme.surface,
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: colorScheme.primary,
              ),
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              items: options.map((role) {
                IconData roleIcon;
                switch (role) {
                  case 'waiter':
                    roleIcon = Icons.restaurant;
                    break;
                  case 'manager':
                    roleIcon = Icons.manage_accounts;
                    break;
                  case 'owner':
                    roleIcon = Icons.business_center;
                    break;
                  case 'admin':
                    roleIcon = Icons.admin_panel_settings;
                    break;
                  default:
                    roleIcon = Icons.person;
                }
                return DropdownMenuItem(
                  value: role,
                  child: Row(
                    children: [
                      Icon(roleIcon, size: 20, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(role),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectRole = val!;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomButtomSheetButton(
                text: widget.title,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final param = CreateUserParam(
                      userName: nameCtrl.text,
                      branch: AuthHelper.getBranch(),
                      password: passCtrl.text,
                      confirmPass: confirmPassCtrl.text,
                      phoneNumber: phoneCtrl.text,
                      role: selectRole,
                      email: emailCtrl.text.trim(),
                    );
                    Navigator.pop(context, param);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    TextInputType keyboardType,
    String label,
    IconData icon, {
    bool obscureText = false,
    bool isRequired = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isObscured = obscureText;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isObscured,
          style: TextStyle(color: colorScheme.onSurface),
          validator: (value) {
            if (widget.isCreate &&
                isRequired &&
                (value == null || value.trim().isEmpty)) {
              return '$label ${LangKeys.nameRequired.tr()}';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
            prefixIcon: Icon(icon, color: colorScheme.onSurface),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            suffixIcon: obscureText
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
