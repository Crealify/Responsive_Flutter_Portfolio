class LeaderboardEntry {
  final String id;
  final String name;
  final int score;
  final DateTime timestamp;

  LeaderboardEntry({
    required this.id,
    required this.name,
    required this.score,
    required this.timestamp,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> data, String docId) {
    return LeaderboardEntry(
      id: docId,
      name: data['name'] ?? 'Unknown',
      score: data['score'] ?? 0,
      timestamp: data['timestamp'] != null ? DateTime.tryParse(data['timestamp'].toString()) ?? DateTime.now() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

