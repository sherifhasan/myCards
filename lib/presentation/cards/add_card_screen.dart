import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:challenge/presentation/cards/views/mobile/add_card_mobile_view.dart';
import 'package:challenge/presentation/cards/views/web/add_card_web_view.dart';
import 'package:challenge/presentation/shared/responsive.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatelessWidget {
  final CardModel? card;

  const AddCardScreen({super.key, this.card});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? AddCardMobileView(card: card)
        : AddCardWebView(card: card);
  }
}
