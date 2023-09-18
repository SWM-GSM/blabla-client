import 'package:blabla/screens/square/square_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SquareAccuseBottomSheetWidget extends StatelessWidget {
  const SquareAccuseBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Column(
              children: List.generate(
                  Accuse.values.length,
                  (idx) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Text(Accuse.values[idx].name.toString().tr())
                        ]),
                      )))
        ],
      ),
    );
  }
}
