import 'package:blabla/main.dart';
import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/screens/square/widgets/square_accuse_bottomsheet_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_width_name_widget.dart';
import 'package:blabla/widgets/skeleton_ui_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SquareFeedbackView extends StatefulWidget {
  const SquareFeedbackView({super.key});

  @override
  State<SquareFeedbackView> createState() => _SquareFeedbackViewState();
}

class _SquareFeedbackViewState extends State<SquareFeedbackView> {
  final feedbackFocus = FocusNode();
  final feedbackCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    feedbackCtr.dispose();
    feedbackFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            "voiceRoomEnd".tr(),
            style: BlaTxt.txt18B,
          ),
          backgroundColor: BlaColor.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Main()),
                  (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_24_dismiss.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
          leadingWidth: 64,
          actions: [
            Container(
              width: 64,
              color: Colors.transparent,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "participants".tr(),
                    style: BlaTxt.txt20B,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 20,
                    children: viewModel.withMemberList == null
                        ? List.generate(
                            4,
                            (idx) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 72,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SkeletonBoxWidget(
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: const BoxDecoration(
                                                color: BlaColor.grey100,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        SkeletonTxtWidget(
                                            style: BlaTxt.txt12M, width: 62)
                                      ]),
                                ))
                        : List.generate(
                            viewModel.withMemberList!.length,
                            (idx) => GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return SquareAccuseBottomSheetWidget(
                                          reporteeId: viewModel
                                              .withMemberList![idx].id);
                                    });
                              },
                              child: ProfileWidthNameWidget(
                                  member: viewModel.withMemberList![idx]),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text("enjoyExperience".tr(), style: BlaTxt.txt20B),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 100),
                    child: Wrap(
                      runSpacing: 20,
                      children: [
                        TextField(
                          controller: feedbackCtr,
                          focusNode: feedbackFocus,
                          scrollPadding: EdgeInsets.zero,
                          maxLines: null,
                          style: BlaTxt.txt16R,
                          decoration: InputDecoration(
                            hintText: "leaveFeedback".tr(),
                            hintStyle:
                                BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            counterText: "",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              feedbackFocus.hasFocus
                  ? 12
                  : 12 + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: BlaColor.grey100, width: 1),
            ),
            color: BlaColor.white,
          ),
          child: GestureDetector(
            onTap: () async {
              feedbackFocus.unfocus();
              if (feedbackCtr.text.isNotEmpty) {
                viewModel.sendSquareFeedback(feedbackCtr.text);
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Main()),
                  (route) => false);
              viewModel.initVoiceCall();
            },
            child: Container(
              alignment: Alignment.center,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: BlaColor.orange),
              child: Text("save".tr(),
                  style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
            ),
          ),
        ),
      ),
    );
  }
}
