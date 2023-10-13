import 'package:blabla/screens/square/square_view_model.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SquareAccuseBottomSheetWidget extends StatefulWidget {
  const SquareAccuseBottomSheetWidget({super.key, required this.reporteeId});
  final int reporteeId;

  @override
  State<SquareAccuseBottomSheetWidget> createState() =>
      _SquareAccuseBottomSheetWidgetState();
}

class _SquareAccuseBottomSheetWidgetState
    extends State<SquareAccuseBottomSheetWidget> {
  Accuse? accuse;
  bool isDesc = false;
  final descCtr = TextEditingController();
  final descFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SquareViewModel>(context);
    return isDesc
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 470 + MediaQuery.of(context).viewInsets.bottom,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: BlaColor.white),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("accuse".tr(), style: BlaTxt.txt18B),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: descCtr,
                      focusNode: descFocus,
                      scrollPadding: EdgeInsets.zero,
                      maxLines: null,
                      style: BlaTxt.txt16R,
                      decoration: InputDecoration(
                        hintText: "explainAccuse".tr(),
                        hintStyle:
                            BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        counterText: "",
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.accuseMember(widget.reporteeId, accuse!,
                      description: descCtr.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: accuse != null ? BlaColor.orange : BlaColor.grey400,
                  ),
                  child: Text("accuse".tr(),
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
                ),
              ),
            ]))
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 470 + MediaQuery.of(context).padding.bottom,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: BlaColor.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("accuse".tr(), style: BlaTxt.txt18B),
                ),
                Column(
                  children: List.generate(
                    Accuse.values.length,
                    (idx) => GestureDetector(
                      onTap: () {
                        setState(() {
                          accuse = Accuse.values[idx];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                Accuse.values[idx].name.toString().tr(),
                                style: accuse == Accuse.values[idx]
                                    ? BlaTxt.txt16B
                                        .copyWith(color: BlaColor.orange)
                                    : BlaTxt.txt16R,
                              ),
                              if (accuse == Accuse.values[idx])
                                SvgPicture.asset(
                                  "assets/icons/ic_24_check.svg",
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                      BlaColor.orange, BlendMode.srcIn),
                                ),
                            ]),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (accuse != null) {
                      if (accuse == Accuse.etc) {
                        setState(() {
                          isDesc = true;
                        });
                      } else {
                        if (await viewModel.accuseMember(
                            widget.reporteeId, accuse!)) {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } else {
                          showToast("failToAccuse".tr());
                        }
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 56,
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:
                          accuse != null ? BlaColor.orange : BlaColor.grey400,
                    ),
                    child: Text(
                      "accuse".tr(),
                      style: BlaTxt.txt16B.copyWith(color: BlaColor.white),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
