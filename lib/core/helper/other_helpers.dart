import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isFormValid(GlobalKey<FormState> formKey) =>
    (formKey.currentState?.validate() ?? false) == true;

String getMessageFormattedDate(int millisecondsSinceEpoch) {
  final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  final now = DateTime.now();
  final difference = now.difference(date);
  if (difference.inDays == 0) {
    return DateFormat('HH:mm').format(date);
  } else {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

String generateConversationId(String senderId, String receiverId) {
  return senderId.compareTo(receiverId) < 0
      ? '${senderId}_$receiverId'
      : '${receiverId}_$senderId';
}
