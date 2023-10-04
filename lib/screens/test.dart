import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/constants/typography.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBTopAppBar(),
      drawer: const EBDrawer(),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBTypography.h1(text: 'Heading 1'),
            EBTypography.h2(text: 'Heading 2'),
            EBTypography.h3(text: 'Heading 3'),
            EBTypography.h4(text: 'Heading 4'),
            EBTypography.p(text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. totam provident aliquam, fugit earum ipsum distinctio? Nihil quibusdam aperiam accusamus voluptatibus tempore.'),
            EBTypography.small(text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. totam provident aliquam, fugit earum ipsum distinctio? '),
            const SizedBox(height: 20.0),
            Wrap(
              children: [
                EBButton(text: 'Primary Button', theme: 'primary', onPressed: () {}),
                EBButton(text: 'Primary Outline Button', theme: 'primary-outline', onPressed: () {}),
                EBButton(text: 'Dark Button', theme: 'dark', onPressed: () {}),
                EBButton(text: 'Dark Outline Button', theme: 'dark-outline', onPressed: () {}),
              ],
            ),
            const SizedBox(height: 20.0),
            const EBTextBox(
              label: 'Username',
              icon: FeatherIcons.user,
              placeholder: 'Enter your username',
              type: 'text',
            ),
            const SizedBox(height: 20.0),
            const EBTextBox(
              label: 'Password',
              icon: FeatherIcons.user,
              placeholder: 'Enter your password',
              type: 'password',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBBottomAppBar(),
    );
  }
}
