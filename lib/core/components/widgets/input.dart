// ignore_for_file: prefer_const_constructors, constant_identifier_names, annotate_overrides, overridden_fields, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:jolly_podcast/core/components/utils/app_buttons.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';
import '../utils/colors.dart';

class SerachInput extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function? toggleEye;
  final TextInputType? keyboard;
  final String? init;
  final bool isPassword;
  final bool readOnly;
  final Color? isPasswordColor;
  //final bool showObscureText;
  final bool obscureText;
  final Color? styleColor;
  final Color? hintStyleColor;
  final bool enable;
  final String? labelText;
  final String? errorText;
  final dynamic maxLines;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? labelColor;
  final String? inputIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Key? key;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  //final List<TextInputFormatter> inputFormatters;
  final FocusNode? focusNode;
  //final bool alignLabelWithHint;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function onTap;
  final double? borderRadius;

  const SerachInput({
    this.hintText,
    this.labelColor,
    this.fillColor,
    this.textColor,
    this.borderRadius,
    this.validator,
    this.hintColor,
    required this.onSaved,
    required this.toggleEye,
    this.init,
    this.isPassword = false,
    this.readOnly = false,
    this.isPasswordColor,
    //this.showObscureText,
    this.obscureText = false,
    this.keyboard,
    this.styleColor,
    this.hintStyleColor,
    this.enable = true,
    this.labelText,
    this.maxLines = 1,
    this.borderColor = Colors.white,
    required this.onChanged,
    this.prefix,
    this.suffix,
    this.key,
    this.controller,
    this.focusNode,
    this.prefixIcon,

    ///this.alignLabelWithHint,
    this.floatingLabelBehavior,
    required this.onTap,
    this.errorText,
    this.inputIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      focusNode: focusNode,
      onTap: onTap as void Function()?,
      keyboardType: keyboard,
      controller: controller,
      key: key,
      enabled: enable,
      onSaved: onSaved!,
      onChanged: onChanged!,
      validator: validator!,
      obscureText: obscureText,
      initialValue: init,
      readOnly: readOnly,
      style: TextStyle(
        color: styleColor ?? AppColors.white,
        fontSize: 18.textSize,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.heightAdjusted,
          horizontal: 3.widthAdjusted,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),

        fillColor: fillColor ?? Color(0xFFeeeeee),
        // fillColor: Colors.white,
        filled: true,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintStyleColor ?? Colors.white,
          fontSize: 14.textSize,
        ),
      ),
    );
  }
}

enum KeyboardType { NUMBER, TEXT, EMAIL, PHONE }

class GlobalTextField extends StatefulWidget {
  final String fieldName;
  final TextInputType keyBoardType;
  final FocusNode? focusNode;
  final TextEditingController textController;
  final int maxLength;
  final bool isCenterText;
  final bool isEyeVisible;
  final bool removeSpace;
  bool obscureText;
  final bool isOptional;
  final Function(String?)? onChanged;
  final bool readOnly;
  final double? borderRadius;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool isNotePad;
  final bool isPasswordValidator;
  final String? confirmPasswordMatch;

  GlobalTextField({
    super.key,
    required this.fieldName,
    required this.keyBoardType,
    required this.textController,
    this.focusNode,
    this.removeSpace = true,
    this.obscureText = false,
    this.isCenterText = false,
    this.isEyeVisible = false,
    this.isOptional = false,
    this.readOnly = false,
    this.onChanged,
    this.maxLength = 19935,
    this.borderRadius,
    this.onTap,
    this.prefix,
    this.suffix,
    this.isNotePad = false,
    this.isPasswordValidator = false,
    this.confirmPasswordMatch,
  });

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      enabled: true,
      maxLines: widget.isNotePad ? 10 : 1,
      minLines: widget.isNotePad
          ? widget.maxLength <= 100
                ? 3
                : 6
          : 1,
      enableInteractiveSelection: widget.readOnly == true
          ? false
          : true, // prevents long press/double tap menu
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: widget.isCenterText ? TextAlign.center : TextAlign.start,
      textCapitalization: widget.keyBoardType == TextInputType.name
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      inputFormatters: _buildInputFormatters(),
      style: TextStyle(
        color: AppColors.bodyGrey,
        fontFamily: "Poppins",
        fontSize: 15.textSize,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.bodyWhite,
        filled: true,
        labelText: widget.fieldName,
        labelStyle: TextStyle(
          color: AppColors.bodyGrey,
          fontFamily: "Poppins",
          fontSize: 15.textSize,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        //  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2.heightAdjusted,
          horizontal: 2.widthAdjusted,
        ),
        suffixIcon: widget.isEyeVisible
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: Icon(
                  widget.obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
              )
            : widget.suffix,
        prefix: widget.prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          borderSide: BorderSide(color: AppColors.red, width: 1.5),
        ),
        errorStyle: TextStyle(fontSize: 4.textSize, height: 1.1),
      ),
      validator: (value) => _validateField(value),
    );
  }

  List<TextInputFormatter> _buildInputFormatters() {
    List<TextInputFormatter> formatters = [];

    if (widget.removeSpace) {
      formatters.add(FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")));
    }

    if (widget.keyBoardType == TextInputType.phone) {
      formatters.add(FilteringTextInputFormatter.deny(RegExp(r'^0+')));
    }

    if (widget.keyBoardType == TextInputType.number) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));

    return formatters;
  }

  String? _validateField(String? value) {
    if (widget.isOptional && (value == null || value.isEmpty)) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'This input is empty';
    }

    if (widget.obscureText) {
      if (widget.isPasswordValidator == true) {
        final passwordRegex = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
        );
        if (!passwordRegex.hasMatch(value)) {
          return 'Password must contain uppercase, lowercase, and number';
        }
      }
      // Confirm password match check (only for confirm password field)
      if (widget.confirmPasswordMatch != null &&
          value != widget.confirmPasswordMatch) {
        return 'Passwords do not match';
      }
    }

    if (widget.keyBoardType == TextInputType.emailAddress) {
      String trimmed = value.trim();
      if (!EmailValidator.validate(trimmed)) {
        return 'Not a valid email';
      }
    }

    if (widget.keyBoardType == TextInputType.phone && value.length != 10) {
      return 'Phone number must be 10 digits';
    }

    if (widget.keyBoardType == TextInputType.number) {
      final numberOnlyRegex = RegExp(r'^\d+$');
      if (!numberOnlyRegex.hasMatch(value)) {
        return 'Only digits are allowed. No special characters.';
      }
    }

    return null;
  }
}

// Phone Number Input with Country Code Dropdown

class GlobalPhoneTextField extends StatefulWidget {
  final String fieldName;
  final TextEditingController textController;
  final int maxLength;
  final FocusNode? focusNode;
  final Function(MobileNumber?)? onChanged;
  final Function(Country?)? onCountryChanged;
  final bool disableLengthCounter;

  GlobalPhoneTextField({
    super.key,
    required this.fieldName,
    required this.textController,
    this.maxLength = 35,
    this.focusNode,
    this.onChanged,
    this.onCountryChanged,
    this.disableLengthCounter = false,
  });

  @override
  State<GlobalPhoneTextField> createState() => _GlobalPhoneTextFieldState();
}

class _GlobalPhoneTextFieldState extends State<GlobalPhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return IntlMobileField(
      fillColor: AppColors.bodyWhite,
      controller: widget.textController,
      countryCodeDisable: true,
      showDropdownIcon: false,
      flagWidth: 25,
      flagsButtonMargin: EdgeInsets.only(left: 10),
      initialCountryCode: "NG",
      focusNode: widget.focusNode,
      onCountryChanged: widget.onCountryChanged,
      onChanged: widget.onChanged,
      enabled: true,
      disableLengthCounter: widget.disableLengthCounter,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: AppColors.bodyGrey,
        fontFamily: "Poppins",
        fontSize: 15.textSize,
        fontWeight: FontWeight.w400,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.bodyWhite,
        filled: true,
        labelText: widget.fieldName,
        labelStyle: TextStyle(
          color: AppColors.bodyGrey,
          fontFamily: "Poppins",
          fontSize: 15.textSize,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        //  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2.heightAdjusted,
          horizontal: 2.widthAdjusted,
        ),

        // suffixIcon: Icon(Icons.contacts, color: AppColors.bodyGrey, size: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.red, width: 1.5),
        ),
        errorStyle: TextStyle(fontSize: 4.textSize, height: 1.1),
      ),
      validator: (mobileNumber) {
        if (mobileNumber == null || mobileNumber.number.isEmpty) {
          return 'Please, Enter a mobile number';
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber.number)) {
          return 'Only digits are allowed';
        }
        return null;
      },
    );
  }
}

class CustomDropdownBottomSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final bool showSearch;

  const CustomDropdownBottomSheet({
    super.key,
    required this.title,
    required this.options,
    this.showSearch = false,
  });

  @override
  State<CustomDropdownBottomSheet> createState() =>
      _CustomDropdownBottomSheetState();
}

class _CustomDropdownBottomSheetState extends State<CustomDropdownBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> _filteredOptions;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredOptions = widget.options
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          // color: AppColors.white,
          height: 50.heightAdjusted,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title + Close Icon
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.heightAdjusted,
                  vertical: 12.widthAdjusted,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 15.textSize,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Manrope",
                        ),
                      ),
                    ),
                    IconButton(
                      color: AppColors.bodyGrey,
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Optional Search Field
              if (widget.showSearch)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

              // Options
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _filteredOptions.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final item = _filteredOptions[index];
                    return ListTile(
                      title: Text(
                        item,
                        style: TextStyle(
                          fontSize: 15.textSize,
                          color: AppColors.bodyGrey,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Manrope",
                        ),
                      ),
                      onTap: () => Navigator.pop(context, item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMultipleDropdownBottomSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final bool showSearch;

  /// Values that should already be selected when opening
  final List<String> initialSelected;

  const CustomMultipleDropdownBottomSheet({
    super.key,
    required this.title,
    required this.options,
    this.showSearch = false,
    this.initialSelected = const [],
  });

  @override
  State<CustomMultipleDropdownBottomSheet> createState() =>
      _CustomMultipleDropdownBottomSheetState();
}

class _CustomMultipleDropdownBottomSheetState
    extends State<CustomMultipleDropdownBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> _filteredOptions;

  /// Stores user selections
  late Set<String> _selectedItems;

  bool isCouponActive = false;
  late TextEditingController couponCode;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _selectedItems = widget.initialSelected
        .toSet(); // 👈 start with pre-selected

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredOptions = widget.options
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void toggleCoupon() {
    setState(() {
      isCouponActive = !isCouponActive;
    });
  }

  void _confirmSelection() {
    Navigator.pop(context, _selectedItems.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Container(
        height: 80.heightAdjusted,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Title + Close Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      isBody: false,
                      text: widget.title,
                      textAlign: TextAlign.start,
                      fontSize: 15,
                      color: AppColors.titleGrey,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppButton(
                    text: "Done",
                    onPressed: _confirmSelection,
                    widthPercent: 20,
                    heightPercent: 4,
                    btnColor: AppColors.primary,
                    isLoading: false,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Optional Search
            if (widget.showSearch)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

            // List with checkboxes
            Expanded(
              child: ListView.separated(
                itemCount: _filteredOptions.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final item = _filteredOptions[index];
                  final isSelected = _selectedItems.contains(item);

                  return CheckboxListTile(
                    value: isSelected,
                    title: AppText(
                      isBody: false,
                      text: item,
                      textAlign: TextAlign.start,
                      fontSize: 15,
                      color: AppColors.bodyGrey,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedItems.add(item);
                        } else {
                          _selectedItems.remove(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
