import 'package:intl/intl.dart';

class AnnouncementViewModel {
  final String id;
  final String body;
  final String heading;
  final DateTime timeCreated;
  final String author;
  final String formattedTime;

  AnnouncementViewModel({
    required this.id,
    required this.body,
    required this.heading,
    required this.timeCreated,
    required this.author,
  }) : formattedTime = DateFormat('MMMM dd, yyyy').format(timeCreated);

  factory AnnouncementViewModel.map(String annId, Map<String, dynamic> data) {
    return AnnouncementViewModel(
      id: annId,
      body: data['body'],
      heading: data['heading'],
      timeCreated: (data['timeCreated']).toDate(),
      author: data['author'],
    );
  }
}
