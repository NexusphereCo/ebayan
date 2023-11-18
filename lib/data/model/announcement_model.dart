import 'package:intl/intl.dart';

class AnnouncementModel {
  final String body;
  final String heading;
  final DateTime timeCreated;
  final String formattedTime; // Formatted time field

  AnnouncementModel({
    required this.body,
    required this.heading,
    required this.timeCreated,
  }) : formattedTime = DateFormat('MMMM dd, yyyy').format(timeCreated);

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      body: map['body'],
      heading: map['heading'],
      timeCreated: map['timeCreated'].toDate(), // Assuming 'timeCreated' is a Firestore Timestamp
    );
  }
}
