import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/fonts.dart';
import '../../components/responsive.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DebitCreditWidget extends StatelessWidget {
  final String title;
  final int amount;
  final Color color;
  const DebitCreditWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height(context) * .15,
      width: width(context) * .43,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titlePopins.copyWith(fontSize: 15)),
            const SizedBox(height: 5),
            Text('$amount ${AppLocalizations.of(context)!.tk}',
                style: titlePopins.copyWith(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
