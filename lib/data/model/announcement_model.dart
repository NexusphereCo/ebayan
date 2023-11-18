class AnnouncementModel {
  final String id;
  final String body;
  final String heading;
  final DateTime timeCreated;

  AnnouncementModel({
    required this.id,
    required this.body,
    required this.heading,
    required this.timeCreated,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      id: map['id'],
      body: map['body'],
      heading: map['heading'],
      timeCreated: map['timeCreated'].toDate(), // Assuming 'timeCreated' is a Firestore Timestamp
    );
  }
}
