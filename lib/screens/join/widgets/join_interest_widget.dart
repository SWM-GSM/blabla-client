import 'package:blabla/models/interest.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/keyword_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinInterestWidget extends StatelessWidget {
  const JoinInterestWidget({super.key, required this.interest});

  final Interest interest;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(interest.category, style: BlaTxt.txt16B),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 12.0,
            children: List.generate(
              interest.keywords.length,
              (idx) => GestureDetector(
                onTap: () {
                  viewModel.setKeywords(interest.keywords[idx]);
                },
                child: KeywordWidget(
                  keyword: interest.keywords[idx],
                  selected:
                      viewModel.keywords.contains(interest.keywords[idx].tag),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
