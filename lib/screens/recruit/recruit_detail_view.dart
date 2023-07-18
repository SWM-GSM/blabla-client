import 'package:blabla/screens/recruit/recruit_complete_view.dart';
import 'package:blabla/screens/recruit/recruit_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecruitDetailView extends StatefulWidget {
  const RecruitDetailView({super.key});

  @override
  State<RecruitDetailView> createState() => _RecruitDetailViewState();
}

class _RecruitDetailViewState extends State<RecruitDetailView> {
  final detailCtr = TextEditingController();
  final detailFocus = FocusNode();
  bool isDetailValid = false;

  detailValid() {
    setState(() {
      if (detailCtr.text.isNotEmpty) {
        isDetailValid = true;
      } else {
        isDetailValid = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    detailCtr.addListener(detailValid);
  }

  @override
  void dispose() {
    super.dispose();
    detailCtr.dispose();
    detailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecruitViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CreateWidget(
              page: RecruitPage.detail,
              title: "크루의 세부 설명을\n입력해주세요",
              widgets: [
                SizedBox(height: 30),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: detailCtr,
                    focusNode: detailFocus,
                    scrollPadding: EdgeInsets.zero,
                    maxLength: 300,
                    maxLines: null,
                    style: BlaTxt.txt20R,
                    decoration: InputDecoration(
                      hintText: "크루 세부 설명을 입력해주세요",
                      hintStyle:
                          BlaTxt.txt20R.copyWith(color: BlaColor.grey500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      counterText: "",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.fromLTRB(
            20,
            10,
            20,
            detailFocus.hasFocus
                ? 20
                : 10 + MediaQuery.of(context).viewPadding.bottom),
        child: Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                // 수정 - API 연결
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecruitCompleteView()),
                );
              },
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: BlaColor.grey100,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "건너뛰기",
                    style: BlaTxt.txt16R.copyWith(color: BlaColor.grey800),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // 수정 - API 연결
                if (detailCtr.text.isNotEmpty) {
                  viewModel.setDetail(detailCtr.text);
                  detailFocus.unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecruitCompleteView()),
                  );
                }
              },
              child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: detailCtr.text.isNotEmpty
                        ? BlaColor.orange
                        : BlaColor.grey400,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "크루 생성",
                    style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
