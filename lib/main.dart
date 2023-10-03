import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/constants/typography.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Flutter App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false, // remove the effing debug banner on the top right
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBTopAppBar(),
      drawer: const EBDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBTypography.h1(text: 'Hello World'),
            EBTypography.p(text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Delectus recusandae eaque ex at praesentium fuga minima eligendi expedita. Velit veritatis quasi earum perferendis iusto hic rem, est in laborum sit rerum modi maiores, atque animi illo voluptas ipsa! In veritatis inventore quos dolorem, veniam tempora neque accusamus molestias quia tempore quam ipsa nemo cupiditate dignissimos odio adipisci, officiis voluptatem, blanditiis perspiciatis ipsam tenetur. Sit necessitatibus quasi modi suscipit? Omnis temporibus autem quae natus eveniet atque? Facere perferendis similique obcaecati dolorem quia possimus quisquam illum amet maiores voluptatibus totam provident aliquam, fugit earum ipsum distinctio? Nihil quibusdam aperiam accusamus voluptatibus tempore.'),
            EBButton(text: 'Primary Button', theme: 'primary', onPressed: () {}),
            EBButton(text: 'Outline Button', theme: 'primary-outline', onPressed: () {}),
            EBButton(text: 'Dark Button', theme: 'dark-outline', onPressed: () {}),
          ],
        ),
      ),
      bottomNavigationBar: const EBBottomAppBar(),
    );
  }
}
