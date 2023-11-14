import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                EBTypography.h4(
                  text: 'San Felipe, Naga City',
                  color: EBColor.light,
                  maxLines: 2,
                ),
                EBTypography.small(text: '092174', color: EBColor.light),
                const SizedBox(height: Spacing.md),
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
    );
  }

  Widget _cardFooter() {
    return Container(
      width: double.infinity,
      height: 75,
      color: EBColor.primary[100],
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterRow(
                  icon: const FaIcon(FontAwesomeIcons.bullhorn, size: 16),
                  text: 'New announcement',
                ),
                const SizedBox(height: Spacing.sm),
                _buildFooterRow(
                  icon: const Icon(FeatherIcons.user, size: 16),
                  text: '42 people',
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EBButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(route: '/dashboard/announcement'));
                },
                text: 'View',
                theme: EBButtonTheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Expanded(
          child: EBTypography.small(text: text, maxLines: 2),
        ),
      ],
    );
  }

  Widget _cardOption() {
    return Positioned(
      top: 0,
      right: 10.0,
      child: PopupMenuButton<CardOptions>(
        offset: const Offset(0, 40),
        icon: Icon(
          FeatherIcons.moreHorizontal,
          color: EBColor.light,
        ),
        initialValue: selectedMenu,
        onSelected: (CardOptions item) {
          setState(() {
            selectedMenu = item;
          });
          if (item == CardOptions.itemOne) {
            var snackBar = SnackBar(
              content: const Text('Brgy. sphere code has been copied to clipboard.'),
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
    const borderRadius = BorderRadius.all(Radius.circular(20));

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      margin: const EdgeInsets.all(Global.paddingBody),
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
    );
  }
}
