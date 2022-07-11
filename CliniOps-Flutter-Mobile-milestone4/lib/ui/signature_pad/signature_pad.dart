import 'dart:ui' as ui;

import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePadView extends StatefulWidget {
  final ValueChanged<ByteData> onSuccess;

  const SignaturePadView({required this.onSuccess});

  @override
  SignaturePadViewState createState() => SignaturePadViewState();
}

class SignaturePadViewState extends State<SignaturePadView> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  final _isSignEmpty = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    _isSignEmpty.value = true;
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    context.showLoadingIndicator();
    try {
      final data = await signatureGlobalKey.currentState!.toImage();
      final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
      context.removeLoadingIndicator();
      widget.onSuccess(bytes!);
    } catch (e) {
      Logger.logError(this, e);
      context.showErrorSnackBar(S.of(context).somethingWrong);
      context.removeLoadingIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, ori) {
      var isLand = ori == Orientation.landscape;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBoxWithHeight(isLand? 8:24),
          Stack(
            children: [
              Align(
                child: Text(
                  S.of(context).singaturePad,
                  style: AppText.text22w400Black.copyWith(fontSize:isLand ?16.sp: 24.sp),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => AppEnvironment.navigator.pop(),
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Image(
                      image: const AssetImage(Images.crossIco),
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          sizedBoxWithHeight(isLand? 4:24),
          const Divider(color: AppColors.textLightGrey),
          Container(
            height: isLand ?140.h :200.h,
            margin: isLand ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h):EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: SfSignaturePad(
              key: signatureGlobalKey,
              backgroundColor: Colors.white,
              strokeColor: Colors.black,
              minimumStrokeWidth: 1.0,
              maximumStrokeWidth: 4.0,
              onDrawStart: () => _isSignEmpty.value = false,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyGradientColor),
            ),
          ),
          const Divider(color: AppColors.textLightGrey),
          sizedBoxWithHeight(isLand ?4: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AppButton(
                onClick: _handleClearButtonPressed,
                label: S.of(context).clear,
                primaryColor: AppColors.greyGradientColor,
                shrinkWrap: true,
                horizontalPadding: isLand ?12: 24,
              ),
              ValueListenableBuilder(
                valueListenable: _isSignEmpty,
                builder: (_, bool val, __) {
                  return AppButton(
                    onClick: _handleSaveButtonPressed,
                    label: S.of(context).submit,
                    shrinkWrap: true,
                    horizontalPadding:isLand ?12: 24,
                    isDisabled: val,
                  );
                },
              ),
            ],
          ),
          sizedBoxWithHeight(isLand ?8:24),
        ],
      );
    });
  }
}
