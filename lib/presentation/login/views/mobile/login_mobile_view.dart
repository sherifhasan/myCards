import 'package:auto_route/auto_route.dart';
import 'package:challenge/application/features/login/login_cubit.dart';
import 'package:challenge/presentation/router/app_router.dart';
import 'package:challenge/presentation/shared/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginMobileView extends HookConsumerWidget {
  const LoginMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginCubit = ref.watch(loginCubitProvider.bloc);
    final state = ref.watch(loginCubitProvider);
    final emailTFC = useTextEditingController(),
        passwordTFC = useTextEditingController();
    final validData = useState(false), hidePassword = useState(true);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFA3A5A9))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: emailTFC,
                  cursorColor: Colors.black,
                  onChanged: (val) {
                    validData.value =
                        val.isNotEmpty && passwordTFC.value.text.isNotEmpty;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(2),
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(
                          fontSize: 16, color: const Color(0xff74777f))),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFA3A5A9))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: passwordTFC,
                  cursorColor: Colors.black,
                  obscureText: hidePassword.value,
                  onChanged: (val) {
                    validData.value =
                        val.isNotEmpty && emailTFC.value.text.isNotEmpty;
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
                        icon: const Icon(Icons.remove_red_eye_outlined)),
                  ),
                ),
              ),
              const SizedBox(height: 295),
              state.when(
                loading: () => const CircularProgressIndicator(),
                initial: () => Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              validData.value
                                  ? const Color(0xff181D29)
                                  : const Color(0xffE1E1E4)),
                          shape: MaterialStatePropertyAll<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 16))),
                      onPressed: validData.value
                          ? () {
                              loginCubit
                                  .login(emailTFC.value.text,
                                      passwordTFC.value.text)
                                  .then((status) {
                                if (status) {
                                  context.router.push(const CardsRoute());
                                } else {
                                  awesomeTopSnackBar(
                                    context,
                                    "Invalid email or password",
                                    textStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        height: 2,
                                        color: const Color(0xFF464A54)),
                                    backgroundColor: const Color(0xFFF9DEDC),
                                    icon: const Icon(Icons.info_outline_rounded,
                                        color: Color(0xffD93838)),
                                  );
                                }
                              });
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
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
