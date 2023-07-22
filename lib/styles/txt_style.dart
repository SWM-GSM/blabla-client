import 'package:blabla/styles/colors.dart';
import 'package:flutter/widgets.dart';

class BlaTxt {
  static const TextStyle txtBase = TextStyle(
    overflow: TextOverflow.ellipsis,
    color: BlaColor.grey900
  );
  static final TextStyle txtRBase = txtBase.copyWith(fontWeight: FontWeight.w400);
  static final TextStyle txtMBase = txtBase.copyWith(fontWeight: FontWeight.w500);
  static final TextStyle txtSBBase = txtBase.copyWith(fontWeight: FontWeight.w600);
  static final TextStyle txtBBase = txtBase.copyWith(fontWeight: FontWeight.w700);
  static final TextStyle txtBKBase = txtBase.copyWith(fontWeight: FontWeight.w900);

  /* Regular */
  static final TextStyle txt10R = txtRBase.copyWith(height: 12.0 / 10.0, fontSize: 10.0);
  static final TextStyle txt12R = txtRBase.copyWith(height: 16.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt14R = txtRBase.copyWith(height: 20.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt16R = txtRBase.copyWith(height: 20.0 / 16.0, fontSize: 16.0);
  static final TextStyle txt20R = txtRBase.copyWith(height: 24.0 / 20.0, fontSize: 20.0);
  static final TextStyle txt20RH = txtRBase.copyWith(height: 28.0 / 20.0, fontSize: 20.0);
  static final TextStyle txt24R = txtRBase.copyWith(height: 28.0 / 24.0, fontSize: 24.0);
  static final TextStyle txt28R = txtRBase.copyWith(height: 28.0 / 28.0, fontSize: 28.0);

  /* Medium */
  static final TextStyle txt12M = txtMBase.copyWith(height: 16.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt12MH = txtMBase.copyWith(height: 20.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt14M = txtMBase.copyWith(height: 20.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt14ML = txtMBase.copyWith(height: 16.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt16M = txtMBase.copyWith(height: 20.0 / 16.0, fontSize: 16.0);
  static final TextStyle txt20M = txtMBase.copyWith(height: 20.0 / 20.0, fontSize: 20.0); 
  static final TextStyle txt24M = txtMBase.copyWith(height: 24.0 / 24.0, fontSize: 24.0);

  /* SemiBold */
  static final TextStyle txt12SB = txtSBBase.copyWith(height: 16.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt14SB = txtSBBase.copyWith(height: 20.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt14SBH = txtSBBase.copyWith(height: 22.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt16SB = txtSBBase.copyWith(height: 20.0 / 16.0, fontSize: 16.0);

  /* Bold */
  static final TextStyle txt12B = txtBBase.copyWith(height: 16.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt12BH = txtBBase.copyWith(height: 20.0 / 12.0, fontSize: 12.0);
  static final TextStyle txt14B = txtBBase.copyWith(height: 20.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt16B = txtBBase.copyWith(height: 20.0 / 16.0, fontSize: 16.0);
  static final TextStyle txt16BH = txtBBase.copyWith(height: 24.0 / 16.0, fontSize: 16.0);
  static final TextStyle txt18B = txtBBase.copyWith(height: 24.0 / 18.0, fontSize: 18.0);
  static final TextStyle txt20B = txtBBase.copyWith(height: 24.0 / 20.0, fontSize: 20.0);
  static final TextStyle txt24B = txtBBase.copyWith(height: 36.0 / 24.0, fontSize: 24.0);
  static final TextStyle txt28B = txtBBase.copyWith(height: 36.0 / 28.0, fontSize: 28.0);
  static final TextStyle txt28BL = txtBBase.copyWith(height: 28.0 / 28.0, fontSize: 28.0);

  /* Black */
  static final TextStyle txt10BK = txtBKBase.copyWith(height: 12.0 / 10.0, fontSize: 10.0);
  static final TextStyle txt14BK = txtBKBase.copyWith(height: 20.0 / 14.0, fontSize: 14.0);
  static final TextStyle txt16BK = txtBKBase.copyWith(height: 20.0 / 16.0, fontSize: 16.0);
  static final TextStyle txt20BK = txtBKBase.copyWith(height: 24.0 / 20.0, fontSize: 20.0);
  static final TextStyle txt24BK = txtBKBase.copyWith(height: 28.0 / 24.0, fontSize: 24.0);
  static final TextStyle txt24BKH = txtBKBase.copyWith(height: 32.0 / 24.0, fontSize: 24.0);
}