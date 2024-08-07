import 'package:auto_route/auto_route.dart';
import 'package:challenge/application/features/login/login_cubit.dart';
import 'package:challenge/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWebView extends HookWidget {
  const LoginWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final emailTFC = useTextEditingController(),
        passwordTFC = useTextEditingController();
    final validData = useState(false), hidePassword = useState(true);
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          return Center(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 4,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 72, horizontal: 190),
                child: SizedBox(
                  width: 320,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Coding Challenge',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff181D29)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please enter your email and password',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff181D29)),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffF5F5F7),
                            borderRadius: BorderRadius.circular(18)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          controller: emailTFC,
                          cursorColor: Colors.black,
                          onChanged: (val) {
                            validData.value = val.isNotEmpty &&
                                passwordTFC.value.text.isNotEmpty;
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(2),
                              border: InputBorder.none,
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(0xff74777f))),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F5F7),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          controller: passwordTFC,
                          cursorColor: Colors.black,
                          obscureText: hidePassword.value,
                          onChanged: (val) {
                            validData.value = val.isNotEmpty &&
                                emailTFC.value.text.isNotEmpty;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2),
                            border: InputBorder.none,
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff74777f)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  hidePassword.value = !hidePassword.value;
                                },
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      state.when(
                        initial: () => Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(
                                            validData.value
                                                ? const Color(0xff181D29)
                                                : const Color(0xffE1E1E4)),
                                    shape:
                                        WidgetStatePropertyAll<OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18))),
                                    padding:
                                        const WidgetStatePropertyAll<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                horizontal: 36, vertical: 16))),
                                onPressed: validData.value
                                    ? () {
                                        loginCubit
                                            .login(emailTFC.value.text,
                                                passwordTFC.value.text)
                                            .then(
                                          (status) {
                                            if (status) {
                                              context.router
                                                  .push(const CardsRoute());
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'ⓘ Invalid email or password',
                                                gravity: ToastGravity.TOP,
                                                timeInSecForIosWeb: 1,
                                                textColor:
                                                    const Color(0xFF464A54),
                                                fontSize: 14,
                                                webPosition: 'center',
                                                webBgColor: '#F9DEDC',
                                              );
                                            }
                                          },
                                        );
                                      }
                                    : null,
                                child: Text('Login',
                                    style: validData.value
                                        ? GoogleFonts.poppins(
                                            color: const Color(0xffF5F5F7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)
                                        : GoogleFonts.poppins(
                                            color: const Color(0xffA3A5A9),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
