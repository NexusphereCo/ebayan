class CommentViewModel {
  final String username;
  final String text;
  final DateTime timeCreated;

  CommentViewModel({
    required this.username,
    required this.text,
    required this.timeCreated,
  });

  factory CommentViewModel.map(String commentId, Map<String, dynamic> data) {
    return CommentViewModel(
      username: data['username'],
      text: data['text'],
      timeCreated: (data['timeCreated']).toDate(),
    );
  }
}
