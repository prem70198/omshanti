import 'package:flutter/material.dart';
import '../models/live_session.dart';
import '../models/chat_message.dart';
import '../data/mock_database.dart';

class LiveSessionProvider extends ChangeNotifier {
  final List<LiveSession> _liveSessions = List.from(MockDatabase.liveSessions);
  LiveSession? _activeRoomSession;
  bool _isHandRaised = false;
  final List<ChatMessage> _liveChatMessages = [
    ChatMessage(
      id: 'chat_1',
      senderName: 'Sister Ananya',
      text: 'Om Shanti from London 🙏 Experiencing deep stillness today.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      senderType: ChatSenderType.liveParticipant,
    ),
    ChatMessage(
      id: 'chat_2',
      senderName: 'Brother Amit (Delhi)',
      text: 'Peace to all divine souls worldwide 🕊️',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      senderType: ChatSenderType.liveParticipant,
    ),
    ChatMessage(
      id: 'chat_3',
      senderName: 'BK Host Desk',
      text: 'Welcome seekers. Please sit in a relaxed posture and focus on the light.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      senderType: ChatSenderType.liveHost,
    ),
  ];

  List<LiveSession> get allSessions => _liveSessions;
  LiveSession? get liveNowSession => _liveSessions.firstWhere((s) => s.isLiveNow, orElse: () => _liveSessions.first);
  List<LiveSession> get upcomingSessions => _liveSessions.where((s) => !s.isLiveNow).toList();
  LiveSession? get activeRoomSession => _activeRoomSession;
  bool get isHandRaised => _isHandRaised;
  List<ChatMessage> get liveChatMessages => _liveChatMessages;

  void joinLiveRoom(LiveSession session) {
    _activeRoomSession = session;
    _isHandRaised = false;
    notifyListeners();
  }

  void leaveLiveRoom() {
    _activeRoomSession = null;
    _isHandRaised = false;
    notifyListeners();
  }

  void toggleRaiseHand() {
    _isHandRaised = !_isHandRaised;
    notifyListeners();
  }

  void sendLiveChatMessage(String text, String senderName) {
    if (text.trim().isEmpty) return;
    _liveChatMessages.add(
      ChatMessage(
        id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
        senderName: senderName.isNotEmpty ? senderName : 'You',
        text: text.trim(),
        timestamp: DateTime.now(),
        senderType: ChatSenderType.user,
      ),
    );
    notifyListeners();
  }

  void toggleReminder(String sessionId) {
    final index = _liveSessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      _liveSessions[index] = _liveSessions[index].copyWith(
        isReminderSet: !_liveSessions[index].isReminderSet,
      );
      notifyListeners();
    }
  }
}
