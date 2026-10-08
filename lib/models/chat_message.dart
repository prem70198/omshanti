enum ChatSenderType {
  user,
  aiAssistant,
  liveParticipant,
  liveHost,
  system,
}

class ChatMessage {
  final String id;
  final String senderName;
  final String text;
  final DateTime timestamp;
  final ChatSenderType senderType;
  final String? resourceActionTitle;
  final String? resourceActionRoute;
  final String? resourceActionId;

  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.text,
    required this.timestamp,
    required this.senderType,
    this.resourceActionTitle,
    this.resourceActionRoute,
    this.resourceActionId,
  });
}
