import 'package:intl/intl.dart';

class AnnouncementViewModel {
  final String id;
  final String body;
  final String heading;
  final DateTime timeCreated;
  final String formattedTime; // Formatted time field

  AnnouncementViewModel({
    required this.id,
    required this.body,
    required this.heading,
    required this.timeCreated,
  }) : formattedTime = DateFormat('MMMM dd, yyyy').format(timeCreated);

  factory AnnouncementViewModel.map(String annId, Map<String, dynamic> data) {
    return AnnouncementViewModel(
      id: annId,
      body: data['body'],
      heading: data['heading'],
      timeCreated: data['timeCreated'].toDate(), // Assuming 'timeCreated' is a Firestore Timestamp
    );
  }
}
