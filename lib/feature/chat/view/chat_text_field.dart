import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required TextEditingController messageController,
    required this.onChanged,
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: _messageController,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
      decoration: InputDecoration(
        hintText: context.loc.writeMessage,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.background,
            ),
        border: InputBorder.none,
      ),
    );
  }
}
