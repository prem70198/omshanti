import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../core/services/ai_guide_service.dart';

class AiGuideProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: 'ai_welcome',
      senderName: 'Resource Guide',
      text:
          'Om Shanti 🙏 I am your spiritual Resource Guide. How can I support your meditation and learning practice today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      senderType: ChatSenderType.aiAssistant,
      resourceActionTitle: 'Start 7-Day Foundation Course',
      resourceActionRoute: '/learning',
      resourceActionId: 'course_rajyoga_7days',
    ),
  ];

  bool _isTyping = false;

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;

  void sendMessage(String query, String langCode) async {
    if (query.trim().isEmpty) return;

    // Add user message
    _messages.add(
      ChatMessage(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        senderName: 'You',
        text: query.trim(),
        timestamp: DateTime.now(),
        senderType: ChatSenderType.user,
      ),
    );
    _isTyping = true;
    notifyListeners();

    // Simulate AI thinking delay
    await Future.delayed(const Duration(milliseconds: 650));

    final response = AiGuideService.generateResponse(query, langCode);

    _messages.add(
      ChatMessage(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        senderName: 'Resource Guide',
        text: response.text,
        timestamp: DateTime.now(),
        senderType: ChatSenderType.aiAssistant,
        resourceActionTitle: response.actionTitle,
        resourceActionRoute: response.actionRoute,
        resourceActionId: response.actionId,
      ),
    );
    _isTyping = false;
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    _messages.add(
      ChatMessage(
        id: 'ai_welcome',
        senderName: 'Resource Guide',
        text:
            'Om Shanti 🙏 I am your spiritual Resource Guide. How can I support your meditation and learning practice today?',
        timestamp: DateTime.now(),
        senderType: ChatSenderType.aiAssistant,
      ),
    );
    notifyListeners();
  }
}
