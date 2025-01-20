import 'package:flutter/material.dart';

import '../const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 400,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 16.0,
          ),
          child: Form(
            child: Column(
              children: [
                _Time(
                  onStartSaved: onStartTimeSaved,
                  onEndSaved: onEndTimeSaved,
                  onStartValidate: onStartTimeValidate,
                  onEndtValidate: onEndTimeValidate,
                ),
                SizedBox(
                  height: 8.0,
                ),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                SizedBox(
                  height: 8.0,
                ),
                _Categorys(
                  selectedColor: selectedColor,
                  onTap: (String color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                _SaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStartTimeSaved(String? val) {

  }

  String? onStartTimeValidate(String? val) {

  }

  void onEndTimeSaved(String? val) {

  }

  String? onEndTimeValidate(String? val) {

  }

  void onContentSaved(String? val){

  }

  String? onContentValidate(String? val){

  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndtValidate;

  // final GlobalKey<FormState> formKey = GlobalKey();

  const _Time(
      {super.key, required this.onStartSaved, required this.onEndSaved, required this.onStartValidate, required this.onEndtValidate,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            onSaved:onStartSaved,
            validator:onStartValidate,
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            onSaved:onEndSaved,
            validator:onEndtValidate,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({super.key, required this.onSaved, required this.onValidate,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categorys extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Categorys({
    super.key,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) =>
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        'FF$e',
                        radix: 16,
                      ),
                    ),
                    border: e == selectedColor
                        ? Border.all(
                      color: Colors.black,
                      width: 4.0,
                    )
                        : null,
                    shape: BoxShape.circle,
                  ),
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ),
      )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
