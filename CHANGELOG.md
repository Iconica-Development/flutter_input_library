## 3.6.0
* Added style parameter to `FlutterFormInputMultiLine`
* Upgrade flutter_iconica_analysis to 7.0.0
* Changed the name of the `CarouselController` to `FlutterInputCarouselController`

## 3.5.0
* Added `selectableTimePredicate` to the `DateTimeInputField` constructor

## 3.4.0
* Added `FlutterFormInputDropdown`

## 3.3.1
* Loosened the dependen on intl to be more compatible with several Flutter versions

## 3.3.0
* Added `FlutterFormInputRadioPicker`
* Changed the `FlutterFormInputNumberPicker` and added axis parameter.
* Changed the formating of the result value of the `showDateRangePicker`.

## 3.2.1
* Added `PhoneNumber` model to save the `FlutterFormInputPhone` result.
* Added more customization for `FlutterFormInputPhone`.

## 3.2.0
* Added `FlutterFormInputPhone`

## 3.1.0
* `FlutterFormInputPassword` now has the controller parameter to set the `TextEditingController` of the `TextFormField`

## 3.0.0
* Updated the FlutterFormInputSwitch to FlutterFormInputBool. This now includes a parameter to either show a checkbox or switch

## 2.7.1
* Added Iconica CI and Iconica Linter

## 2.7.0
* Addition of 'decoration' parameter to 'FlutterFormInputPassword'

## 2.6.1
* Addition of 'obscureText' parameter to 'FlutterFormInputPlainText'

## 2.6.0
* Addition of the `textCapitalization` parameter to `FlutterFormInputPlainText` and `FlutterFormInputMultiLine`.

## 2.5.2
* Addition of `style` parameter to `FlutterFormInputPassword` widget.

## 2.5.1
* Addition of `formatInputs` parameter to `FlutterFormInputPlainText` widget.
* Addition of `formatInputs` parameter to `FlutterFormInputPassword` widget.

## 2.5.0
* Addition of the ScrollPicker input field.

## 2.4.0
* The ability to disable the onTap paramater of the DatePicker
* FlutterFormInputDateTime now also had the enabled parameter to provide to DateTimeInputField

## 2.3.0
* The ability to set the enabled parameter of TextFormFields

## 2.2.1
* Initial time optional on input from the user, defaulting to current time

## 2.2.0
* Dateformat optional on input from the user, defaulting to 24 hour format

## 2.1.0
* make compatible with flutter 3.10

## 2.0.0
* remove 'riverpod' dependency

## 1.0.6
* add initial timepicker parameter

## 1.0.5
* add style to datetime

## 1.0.4
* fix datetimepicker format and validator

## 1.0.3
* add FocusNode option for input fields

## 1.0.1
* add decoration option for datetime input fields

## 1.0.0
* enforce 24h clock in the time picker because it can caused a bug on web

## 0.0.1
* Initial release, retrieved inputs from flutter_form
