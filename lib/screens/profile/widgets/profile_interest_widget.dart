import 'package:blabla/models/interest.dart';
import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/keyword_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileInterestWidget extends StatelessWidget {
  const ProfileInterestWidget({super.key, required this.interest});
  final Interest interest;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
                  viewModel.setInterest(interest.keywords[idx]);
                },
                child: KeywordWidget(
                  keyword: interest.keywords[idx],
                  selected:
                      viewModel.tempInterests.contains(interest.keywords[idx]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
