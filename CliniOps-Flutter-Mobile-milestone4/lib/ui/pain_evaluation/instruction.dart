import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/ui/pain_evaluation/pain_evaluation.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class PainEvalutionScreen extends StatelessWidget {
  final PainEvaluationArgs args;

  const PainEvalutionScreen(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CliniAppBar(title: S.of(context).painEvaluation),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12.r),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage(Images.human),
              height: 280.h,
              width: 150.w,
            ),
            sizedBoxWithWidth(8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GreyButton(
                    width: 30.w,
                    child: RotatedBox(
                      quarterTurns: 5,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20.h,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        '0',
                        style: AppText.text14w400Black,
                      ),
                    ),
                  ),
                  GreyButton(
                    width: 30.w,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20.h,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            AppDropDownFormField(
              label: 'What is your pain level on upper body ?',
              name: 'Please select the value',
              // onChanged:<String>(String? value)=>{},
              initalValue: 'None',

              dropdownList: ['None']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
            AppDropDownFormField(
              label: 'What is your pain level on upper body?',
              name: 'Please select the value',
              // onChanged:<String>(String? value)=>{},
              initalValue: 'Value',

              dropdownList: ['Value']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
            AppDropDownFormField(
              label: 'What is your pain level on lower body?',
              name: 'Please select the value',
              // onChanged:<String>(String? value)=>{},
              initalValue: '1',

              dropdownList: ['1']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            )
          ],
        ),
        sizedBoxWithHeight(16),
        AppButton(
          horizontalMargin: 24,
          // width: 330,
          onClick: () {},
          label: S.of(context).next,
        ),
      ],
    );
  }
}
