import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final void Function(bool)? onChanged;
  final IconData? inactiveThumbIcon;
  final IconData? activeThumbIcon;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;

  const SwitchButton({
    super.key,
    this.onChanged,
    this.inactiveThumbIcon,
    this.activeThumbIcon,
    this.inactiveTrackColor,
    this.activeTrackColor,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool switched = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          value: switched,
          onChanged: (bool value) {
            setState(() {
              switched = value;
              // Executa a função passada como parâmetro para onChanged, caso exista
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            });
          },
          // Muda o ícone conforme o estado do Switch
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              // Switch active
              return Icon(
                widget.activeThumbIcon,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey.shade900,
              );
            }
            // Switch inactive
            return Icon(
              widget.inactiveThumbIcon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey.shade900,
            );
          }),
          thumbColor: WidgetStateProperty.all(
            Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade400
                : Colors.grey.shade700,
          ),
          // Muda a cor do Track conforme o estado do Switch
          inactiveTrackColor: Colors.grey.withOpacity(0.2),
          activeTrackColor: Colors.grey.withOpacity(0.2),
          trackOutlineWidth: WidgetStateProperty.all(1),
          trackOutlineColor: WidgetStateProperty.all(Colors.grey.shade500),
        ),
      ],
    );
  }
}
