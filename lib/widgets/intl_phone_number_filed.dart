import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/phone_number/phone_number_util.dart';

import '../styles/colors.dart';

class IntlPhoneNumberFiled extends StatefulWidget {
  const IntlPhoneNumberFiled({
    Key? key,
    this.controller,
    required this.initialValue,
    this.labelText,
    this.removePadding = false,
    this.isLoading = false,
    this.maxLength,
    this.enabled,
    this.onInputChanged,
    this.validator,
  }) : super(key: key);
  final String? labelText;
  final TextEditingController? controller;
  final bool removePadding;
  final bool isLoading;
  final bool? enabled;
  final int? maxLength;
  final String? initialValue;
  final void Function(PhoneNumber value)? onInputChanged;
  final String? Function(String?)? validator;

  @override
  State<IntlPhoneNumberFiled> createState() => _IntlPhoneNumberFiledState();
}

class _IntlPhoneNumberFiledState extends State<IntlPhoneNumberFiled> {
  String? _errorText;
  String isoCode = '';
  String dialCode = '';
  PhoneNumber? initPhoneNumber;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue == null) {
      initPhoneNumber = PhoneNumber(
        phoneNumber: "",
        isoCode: "US",
        dialCode: "1",
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          final data = await PhoneNumber.getRegionInfoFromPhoneNumber(
            widget.initialValue!.startsWith("+")
                ? widget.initialValue!
                : "+${widget.initialValue!}",
          );
          setState(
            () {
              initPhoneNumber = data;
            },
          );
        },
      );
    }
  }

  String? _validate(String value) {
    if (mounted && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          if (value.isNotEmpty) {
            try {
              var isValidPhoneNumber = await PhoneNumberUtil.isValidNumber(
                phoneNumber: '$dialCode$value',
                isoCode: isoCode,
              );

              if (isValidPhoneNumber == true) {
                _errorText = null;
                if (mounted && context.mounted) {
                  setState(() {});
                }
              } else {
                _errorText = "The phone number entered is invalid";
                if (mounted && context.mounted) {
                  setState(() {});
                }
              }
            } on Exception {
              _errorText = null;
              if (mounted && context.mounted) {
                setState(() {});
              }
            }
          } else {
            _errorText = "The phone number entered is invalid";
            if (mounted && context.mounted) {
              setState(() {});
            }
          }
        },
      );
    }

    return _errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.tsnAlmostBlack,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.removePadding ? 0 : 12,
            vertical: 4,
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: InternationalPhoneNumberInput(
              initialValue: initPhoneNumber,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
                useEmoji: true,
                leadingPadding: 0,
                trailingSpace: false,
              ),
              onInputChanged: (value) {
                _validate(value.parseNumber());
                dialCode = value.dialCode ?? '';
                isoCode = value.isoCode ?? '';
                widget.onInputChanged?.call(value);
              },
              textFieldController: widget.controller,
              errorMessage: "The phone number entered is invalid",
              selectorButtonOnErrorPadding: 0,
              spaceBetweenSelectorAndTextField: 0,
              maxLength: widget.maxLength ?? 13,
              hintText: widget.labelText,
              locale: 'en',
              isEnabled: widget.enabled ?? true,
              validator: (value) {
                return _validate(value ?? '');
              },
              textStyle: const TextStyle(
                color: AppColors.fieldTextInsideDarkFill,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              selectorTextStyle: const TextStyle(
                color: AppColors.fieldTextInsideDarkFill,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlignVertical: TextAlignVertical.top,
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: AppColors.fieldTextInsideDarkFill,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                hintText: widget.labelText,                
                errorStyle: const TextStyle(
                  height: 0.1,
                  fontSize: 0,
                ),
                prefixIcon: widget.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : null,
                floatingLabelStyle: const TextStyle(
                  color: Color(0xFF8D8D8D),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                labelStyle: const TextStyle(
                  color: Color(0xFF8D8D8D),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        if (_errorText != null)
          const SizedBox(
            height: 6,
          ),
        if (_errorText != null)
          Text(
            _errorText!,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
      ],
    );
  }
}
