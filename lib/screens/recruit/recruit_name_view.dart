import 'package:blabla/screens/recruit/recruit_desc_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RecruitNameView extends StatefulWidget {
  const RecruitNameView({super.key});

  @override
  State<RecruitNameView> createState() => _RecruitNameViewState();
}

class _RecruitNameViewState extends State<RecruitNameView> {
  final nameCtr = TextEditingController();
  bool isNameLenValid = false;
  final nameFocus = FocusNode();

  nameValid() {
    setState(() {
      if (nameCtr.text.length >= 2 && nameCtr.text.length <= 20) {
        isNameLenValid = true;
      } else {
        isNameLenValid = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameCtr.addListener(nameValid);
  }

  @override
  void dispose() {
    super.dispose();
    nameCtr.dispose();
    nameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: CreateWidget(
          page: RecruitPage.name,
          title: "크루 이름을\n입력해주세요",
          widgets: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: nameCtr,
                    focusNode: nameFocus,
                    scrollPadding: EdgeInsets.zero,
                    maxLength: 20,
                    style: BlaTxt.txt20R,
                    decoration: InputDecoration(
                      hintText: "크루 이름을 입력해주세요",
                      hintStyle:
                          BlaTxt.txt20R.copyWith(color: BlaColor.grey500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "2~20자 이내",
                  style: BlaTxt.txt14M.copyWith(
                    color: isNameLenValid ? BlaColor.orange : BlaColor.grey600,
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
                      isNameLenValid ? BlaColor.orange : BlaColor.grey600,
                      BlendMode.srcIn),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (isNameLenValid) {
            viewModel.setName(nameCtr.text);
            nameFocus.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecruitDescView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              nameFocus.hasFocus
                  ? 20
                  : 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isNameLenValid
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}