import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedData() async {
  try {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    List<Object> residents = [
      {
        'name': 'John Doe',
        'email': 'johndoe@example.com',
      },
      {
        '...',
      }
    ];

    for (int i = 0; i < residents.length; i++) {
      await usersCollection.add(residents[i]);
    }

    print('Data seeded successfully');
  } catch (e) {
    print('Error seeding data: $e');
  }
}
