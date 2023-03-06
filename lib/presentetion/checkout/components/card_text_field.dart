import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  const CardTextField(
      {Key key,
      this.title,
      this.bold = false,
      this.hint,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.textAlign = TextAlign.start,
      this.focusNode,
      this.onFieldSubmitted,
      this.onSaved,
      this.initialValue})
      : textInputAction = onFieldSubmitted == null
            ? TextInputAction.done
            : TextInputAction.next,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: '',
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const SizedBox(width: 4),
                if (state.hasError)
                  Text(
                    state.errorText,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
            TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontWeight: bold ? FontWeight.bold : FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.white.withAlpha(100),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              textAlign: textAlign,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              textInputAction: textInputAction,
              initialValue: initialValue,
              onSaved: onSaved,
              onChanged: (text) {
                state.didChange(text);
              },
            )
          ],
        );
      },
    );
  }
}
