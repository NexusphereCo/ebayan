import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/announcement_list.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

enum CardOptions { itemOne, itemTwo, itemThree }

class SphereCard extends StatefulWidget {
  const SphereCard({
    super.key,
  });

  @override
  State<SphereCard> createState() => _SphereCardState();
}

class _SphereCardState extends State<SphereCard> {
  CardOptions? selectedMenu;

  Widget _cardHeader() {
    return Container(
      width: double.infinity,
      height: 110,
      color: EBColor.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EBTypography.h4(text: 'Lorem Ipsum Dolor Something, Naga City', color: EBColor.light, maxLines: 2),
                  EBTypography.small(text: '092174', color: EBColor.light),
                  const SizedBox(height: Spacing.formMd),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(Asset.illustHousePath, fit: BoxFit.fitHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardFooter() {
    return Container(
      width: double.infinity,
      height: 75,
      color: EBColor.materialPrimary[100],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.bullhorn, size: 16),
                      const SizedBox(width: 10),
                      Expanded(
                        child: EBTypography.small(text: 'New announcement', maxLines: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.formSm),
                  Row(
                    children: [
                      const Icon(FeatherIcons.user, size: 16),
                      const SizedBox(width: 10),
                      Expanded(
                        child: EBTypography.small(text: '42 people'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EBButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const AnnouncementScreen(),
                        ),
                      );
                    },
                    text: 'View',
                    theme: EBButtonTheme.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardOption() {
    return Positioned(
      top: 0,
      right: 10.0,
      child: PopupMenuButton<CardOptions>(
        offset: const Offset(0, 40),
        icon: const Icon(
          FeatherIcons.moreHorizontal,
          color: EBColor.light,
        ),
        initialValue: selectedMenu,
        onSelected: (CardOptions item) {
          setState(() {
            selectedMenu = item;
          });
          if (item == CardOptions.itemOne) {
            const snackBar = SnackBar(
              content: Text('Brgy. sphere code has been copied to clipboard.'),
              backgroundColor: EBColor.primary,
              elevation: 1,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemOne,
            child: Text('Copy Code'),
          ),
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemTwo,
            child: Text('Leave Barangay Sphere'),
          ),
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemThree,
            child: Text('View People'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    );

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );

    return Container(
      decoration: decoration,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Expanded(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              Column(
                children: [
                  _cardHeader(),
                  _cardFooter(),
                ],
              ),
              _cardOption(),
            ],
          ),
        ),
      ),
    );
  }
}
