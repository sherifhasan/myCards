import 'package:auto_route/auto_route.dart';
import 'package:challenge/application/features/cards/card_cubit.dart';
import 'package:challenge/presentation/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class CardsWebView extends HookWidget {
  const CardsWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardsCubit = context.read<CardCubit>();
    final cardsController = usePageController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: BlocBuilder<CardCubit, CardState>(builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (cards) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            cardsController.previousPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeIn);
                          },
                          backgroundColor: const Color(0xFF181D29),
                          child: const Icon(CupertinoIcons.chevron_up,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        FloatingActionButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            cardsController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeIn);
                          },
                          backgroundColor: const Color(0xFF181D29),
                          child: const Icon(CupertinoIcons.chevron_down,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.80,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: cards.isNotEmpty
                          ? StackedCardCarousel(
                              pageController: cardsController,
                              type: StackedCardCarouselType.cardsStack,
                              spaceBetweenItems:
                                  MediaQuery.sizeOf(context).height * 0.65,
                              items: cards
                                  .map((card) => Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        elevation: 4,
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.3,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.63,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/card_bg.png'),
                                                  fit: BoxFit.fill)),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(30),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        card.fullName,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFFF3F5F7)),
                                                      ),
                                                      Text(
                                                        card.phoneNumber,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xccF3F5F7)),
                                                      ),
                                                      Text(
                                                        card.email,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xccF3F5F7)),
                                                      ),
                                                    ]),
                                              ),
                                              Positioned(
                                                  left: 30,
                                                  right: 30,
                                                  bottom: 72,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'IBAN',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFFF3F5F7)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              card.iban,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: const Color(
                                                                      0xffF3F5F7)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Positioned(
                                                  right: 20,
                                                  bottom: 20,
                                                  child: Image.asset(
                                                    'assets/images/visa_logo.png',
                                                    height: 20,
                                                  )),
                                              Positioned(
                                                right: 6,
                                                top: 10,
                                                child: PopupMenuButton<String>(
                                                  icon: const Icon(
                                                    Icons.more_vert_rounded,
                                                    color: Colors.white,
                                                    size: 32,
                                                  ),
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<String>>[
                                                    PopupMenuItem<String>(
                                                      value: '1',
                                                      child: const Text('Edit'),
                                                      onTap: () {
                                                        context.router.push(
                                                            AddCardRoute(
                                                                card: card));
                                                      },
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: '2',
                                                      child:
                                                          const Text('Delete'),
                                                      onTap: () {
                                                        cardsCubit
                                                            .removeCard(card);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xff181D29)),
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 54, vertical: 16))),
                onPressed: () {
                  context.router.push(AddCardRoute());
                },
                child: Text('New',
                    style: GoogleFonts.poppins(
                        color: const Color(0xffF5F5F7),
                        fontSize: 16,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        );
      }),
    );
  }
}
