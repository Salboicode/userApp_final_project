// ignore_for_file: file_names, must_be_immutable

import 'package:final_project/Home_layout.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Form_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/Cubits/auth_cubit.dart';
import 'package:final_project/Cubits/auth_state.dart';
import 'package:final_project/elevated_button.dart';



 class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey2,
              child: Column(
                children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 170, 0),
                  child: Text(
                    'Lets get started!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 210, 0),
                  child: Text(
                    'Please sign up below.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                MyFormField(
                  controller: nameController,
                  label: 'Username',
                  textInputType: TextInputType.text,
                  validator: (value){
                    if(value!.isEmpty) {
                      return "Username can't be empty";
                    }
                    return null;
                  },
                ),
                MyFormField(
                  controller: emailController,
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty){
                      return "email can't be empty";
                    }
                    return null;
                  },
                ),
                MyFormField(
                  controller: phoneNoController,
                  label: 'Phone number',
                  textInputType: TextInputType.phone,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Phone number can't be empty";
                    }
                    return null;
                  },
                ),
                MyFormField(
                  controller: passwordController,
                  label: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter password";
                    }
                    else if(value.length < 6){
                      return "Your password shouldnt be less than 6 characters";
                    }
                    return null;
                  },
                ),
                MyFormField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  textInputType: TextInputType.visiblePassword,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter password";
                    }
                    else if(value.length < 6){
                      return "Your password shouldnt be less than 6 characters";
                    }
                    else if(value != passwordController.text){
                      return "Password doesn't match";
                    }
                    return null;
                  },
                ),
                 BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.error),
                            ),
                          );
                        } else if (state is AuthLoaded) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeLayout(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return MyCustomButton(
                          onPressed: () {
                            if (formKey2.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<AuthCubit>()
                                  .createUserWithEmailAndPassword(
                                    phoneNo: phoneNoController.text,
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                          },
                          label: 'Sign Up',
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
              ],
              ),
              
            ),
          ),
        ),
      ),
      
    );
  }
}