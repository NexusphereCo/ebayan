import 'package:ebayan/data/model/announcement_model.dart';

class BarangayViewModel {
  final String? adminId;
  final int code;
  final String name;
  final List<AnnouncementModel>? announcements;
  final int? numOfPeople;

  BarangayViewModel({
    this.adminId,
    required this.code,
    required this.name,
    this.announcements,
    this.numOfPeople,
  });
}
