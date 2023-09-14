import 'package:flutter/material.dart';
import 'package:ebayan/eb_styles.dart' as EB;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EB.Typography.h1("HEADING 1"),
          EB.Typography.h2("HEADING 2"),
          EB.Typography.h3("HEADING 3"),
          EB.Typography.h4("HEADING 4"),
          EB.Typography.p(
            "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aspernatur id voluptatibus quasi enim quae. Alias, tenetur culpa. Accusantium, soluta dolore mollitia dignissimos pariatur perferendis, tenetur, veritatis optio velit maxime quibusdam?",
          ),
          EB.Typography.small(
            "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aspernatur id voluptatibus quasi enim quae. Alias, tenetur culpa. Accusantium, soluta dolore mollitia dignissimos pariatur perferendis, tenetur, veritatis optio velit maxime quibusdam?",
          ),
          EB.Button.darkOutlined("Primary Button", () {})
        ],
      ),
    );
  }
}
