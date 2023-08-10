import 'package:blabla/screens/my_space/mys_content_speaking_view.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MysContentFeedbackView extends StatelessWidget {
  const MysContentFeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "아이스베어 - 시간 약속 정하기",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              "assets/icons/ic_32_arrow_left.svg",
              width: 24,
              height: 24,
            ),
          ),
        ),
        leadingWidth: 64,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 0, 20, 90 + MediaQuery.of(context).padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: BlaColor.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "문장 유사도",
                          style: BlaTxt.txt20B,
                        ),
                        starScore(2),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("내가 영작한 문장",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700)),
                    const SizedBox(height: 4),
                    Text("I’ll be there soon",
                        style: BlaTxt.txt16B
                            .copyWith(overflow: TextOverflow.visible)),
                    const SizedBox(height: 16),
                    Text("정답 문장",
                        style: BlaTxt.txt12R.copyWith(color: BlaColor.grey700)),
                    const SizedBox(height: 4),
                    Text("I’ll be there soon",
                        style: BlaTxt.txt16B
                            .copyWith(overflow: TextOverflow.visible)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다. 이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.이 번역은 원래 문자의 의미를 전달하면서도, 목표를 향해 점점 가까워지고 있다는 느낌을 잘 담아내고 있습니다. “You’re getting close”는 누군가가 목표를 달성하기 위해 진전하고 있음을 나타내는 표현이며, “You will succeed soon”은 목표에 성공적으로 도달할 것이라는 확신을 전하는 표현입니다. 따라서, 이 번역은 원래 문장의 의도를 정확하게 전달하고 있습니다.",
                style: BlaTxt.txt14R.copyWith(
                    color: BlaColor.grey800, overflow: TextOverflow.visible),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: BlaColor.grey100, width: 1),
          ),
          color: BlaColor.white,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MysContentSpeakingView(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BlaColor.orange,
            ),
            child: Text("계속하기",
                style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
          ),
        ),
      ),
    );
  }

  Widget starScore(int starNum) {
    return Wrap(
      children: [
        Wrap(
            spacing: 4,
            children: List.generate(
              starNum,
              (idx) => SvgPicture.asset("assets/icons/ic_24_star.svg",
                  width: 24,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(BlaColor.yellow, BlendMode.srcIn)),
            )),
        if (starNum != 0) const SizedBox(width: 4),
        Wrap(
            spacing: 4,
            children: List.generate(
              3 - starNum,
              (idx) => SvgPicture.asset("assets/icons/ic_24_star.svg",
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                      BlaColor.grey500, BlendMode.srcIn)),
            )),
      ],
    );
  }
}
