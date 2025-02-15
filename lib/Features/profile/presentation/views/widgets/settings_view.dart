import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/date_text_field.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_profile_text_field.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final TextEditingController nameController = TextEditingController(text: UserModel.getInstance().name);
  DateTime dateOfBirth = DateTime.parse(UserModel.getInstance().dateOfBirth);
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailed) {
          snackBar(content: state.errorMessage, context: context);
        } else if (state is SettingsSuccessed) {
          snackBar(content: 'Data saved successfully', context: context, color: Colors.green);
          passwordController.clear();
        } else if (state is SettingsInvalidData) {
          snackBar(content: 'Enter valid data', context: context);
        } else if (state is SettingsLoading) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Settings", style: Styles.kFontSize30(context)),
          ),
          body: ModalProgressHUD(
            inAsyncCall: state is SettingsLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text("Personal Information", style: Styles.kMediumTextStyle(context).copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 15),
                      MyProfileTextField(
                        label: 'Name',
                        enabled: true,
                        controller: nameController,
                      ),
                      const SizedBox(height: 15),
                      DateTextField(
                        label: 'Date of Birth',
                        dateTime: dateOfBirth,
                        onChanged: (DateTime date) {
                          dateOfBirth = date;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () async {
                          await BlocProvider.of<SettingsCubit>(context).saveChanges(nameController.text, dateOfBirth);
                        },
                        height: 550,
                        label: 'SAVE CHANGES',
                      ),
                      const SizedBox(height: 25),
                      Text("Password", style: Styles.kMediumTextStyle(context).copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 15),
                      Form(
                        key: keyForm,
                        child: Column(
                          children: [
                            MyProfileTextField(
                              label: 'Password',
                              enabled: true,
                              controller: passwordController,
                              password: true,
                              validator: (value) {
                                RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  if (!regex.hasMatch(value)) {
                                    return 'Enter valid password';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomButton(
                              onTap: () async {
                                if (keyForm.currentState!.validate()) {
                                  await BlocProvider.of<SettingsCubit>(context).savePassword(passwordController.text);
                                }
                              },
                              height: 550,
                              label: 'SAVE PASSWORD',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
