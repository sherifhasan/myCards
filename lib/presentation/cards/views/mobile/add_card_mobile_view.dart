import 'package:challenge/application/features/cards/card_cubit.dart';
import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCardMobileView extends HookConsumerWidget {
  final CardModel? card;

  const AddCardMobileView({super.key, this.card});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsCubit = ref.watch(cardCubitProvider.bloc);
    final cardNameTFC =
            useTextEditingController(text: card != null ? card!.fullName : ''),
        emailTFC =
            useTextEditingController(text: card != null ? card!.email : ''),
        ibanTFC =
            useTextEditingController(text: card != null ? card!.iban : ''),
        phoneTFC = useTextEditingController(
            text: card != null ? card!.phoneNumber : '');
    final validData = useState(false);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      bottomSheet: Container(
        color: const Color(0xFFF5F5F7),
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF181D29)),
                          borderRadius: BorderRadius.circular(18))),
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 36, vertical: 16))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF181D29),
                      fontSize: 16,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Color(0xff181D29)),
                  shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 36, vertical: 16))),
              onPressed: () {
                if (card != null) {
                  cardsCubit.editCard(
                    CardModel(
                        fullName: cardNameTFC.value.text,
                        email: emailTFC.value.text,
                        phoneNumber: phoneTFC.value.text,
                        iban: ibanTFC.value.text),
                  );
                } else {
                  cardsCubit.addCard(
                    CardModel(
                        fullName: cardNameTFC.value.text,
                        email: emailTFC.value.text,
                        phoneNumber: phoneTFC.value.text,
                        iban: ibanTFC.value.text),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Save',
                  style: GoogleFonts.poppins(
                      color: const Color(0xffF5F5F7),
                      fontSize: 16,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                  image: AssetImage('assets/images/card_bg.png'),
                  fit: BoxFit.fill)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, right: 30, left: 30, bottom: 64),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFA3A5A9))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: cardNameTFC,
                        cursorColor: Colors.black,
                        onChanged: (val) {
                          validData.value = val.isNotEmpty &&
                              emailTFC.value.text.isNotEmpty &&
                              ibanTFC.value.text.isNotEmpty &&
                              phoneTFC.value.text.isNotEmpty;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2),
                            border: InputBorder.none,
                            labelText: 'Name',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff74777f))),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFA3A5A9))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: phoneTFC,
                        cursorColor: Colors.black,
                        onChanged: (val) {
                          validData.value = val.isNotEmpty &&
                              cardNameTFC.value.text.isNotEmpty &&
                              ibanTFC.value.text.isNotEmpty &&
                              emailTFC.value.text.isNotEmpty;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2),
                            border: InputBorder.none,
                            labelText: 'Phone',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff74777f))),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFA3A5A9))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: emailTFC,
                        cursorColor: Colors.black,
                        onChanged: (val) {
                          validData.value = val.isNotEmpty &&
                              cardNameTFC.value.text.isNotEmpty &&
                              ibanTFC.value.text.isNotEmpty &&
                              phoneTFC.value.text.isNotEmpty;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2),
                            border: InputBorder.none,
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff74777f))),
                      ),
                    ),
                    const SizedBox(
                      height: 96,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFA3A5A9))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: ibanTFC,
                        cursorColor: Colors.black,
                        onChanged: (val) {
                          validData.value = val.isNotEmpty &&
                              cardNameTFC.value.text.isNotEmpty &&
                              emailTFC.value.text.isNotEmpty &&
                              phoneTFC.value.text.isNotEmpty;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2),
                            border: InputBorder.none,
                            labelText: 'IBAN',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff74777f))),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: Image.asset(
                    'assets/images/visa_logo.png',
                    height: 20,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
