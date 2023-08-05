import 'package:blabla/screens/recruit/recruit_cycle_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RecruitDescView extends StatefulWidget {
  const RecruitDescView({super.key});

  @override
  State<RecruitDescView> createState() => _RecruitDescViewState();
}

class _RecruitDescViewState extends State<RecruitDescView> {
  final descCtr = TextEditingController();
  bool isDescLenValid = false;
  final descFocus = FocusNode();

  descValid() {
    setState(() {
      if (descCtr.text.isNotEmpty && descCtr.text.length <= 300) {
        isDescLenValid = true;
      } else {
        isDescLenValid = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    descCtr.addListener(descValid);
  }

  @override
  void dispose() {
    super.dispose();
    descCtr.dispose();
    descFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CreateWidget(
              page: RecruitPage.desc,
              title: "크루 한줄 소개를\n입력해주세요",
              widgets: [
                SizedBox(height: 30),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      TextField(
                        controller: descCtr,
                        focusNode: descFocus,
                        scrollPadding: EdgeInsets.zero,
                        maxLength: 300,
                        maxLines: null,
                        style: BlaTxt.txt20R,
                        decoration: InputDecoration(
                          hintText: "크루 한줄 소개를 입력해주세요",
                          hintStyle:
                              BlaTxt.txt20R.copyWith(color: BlaColor.grey500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          counterText: "",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "300자 이내",
                            style: BlaTxt.txt14M.copyWith(
                              color: isDescLenValid
                                  ? BlaColor.orange
                                  : BlaColor.grey600,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(
                            "assets/icons/ic_20_check.svg",
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                isDescLenValid
                                    ? BlaColor.orange
                                    : BlaColor.grey600,
                                BlendMode.color),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (isDescLenValid) {
            viewModel.setDesc(descCtr.text);
            descFocus.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecruitCycleView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              descFocus.hasFocus
                  ? 20
                  : 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDescLenValid ? BlaColor.orange : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
