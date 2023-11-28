import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/loading_bar.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CardOptions { itemOne, itemTwo, itemThree }

class SphereCard extends StatefulWidget {
  final String? brgyName;
  final String? brgyCode;
  final bool? hasNewAnnouncements;
  final int? numOfPeople;

  final bool? isLoading;
  final bool? disableButtons;

  const SphereCard({
    super.key,
    this.brgyName,
    this.brgyCode,
    this.hasNewAnnouncements,
    this.numOfPeople,
    this.isLoading,
    this.disableButtons,
  });

  Widget cardHeader() {
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
                (isLoading ?? false)
                    ? buildLoadingContainer(width: 150, colors: [EBColor.primary[800]!, EBColor.primary[700]!.withOpacity(0.5)])
                    : EBTypography.h4(
                        text: brgyName!,
                        color: EBColor.light,
                        maxLines: 2,
                      ),
                const SizedBox(height: Spacing.sm),
                (isLoading ?? false)
                    ? buildLoadingContainer(width: 75, colors: [EBColor.primary[800]!, EBColor.primary[700]!.withOpacity(0.5)])
                    : EBTypography.small(
                        text: brgyCode!,
                        color: EBColor.light,
                      ),
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

  @override
  State<SphereCard> createState() => _SphereCardState();
}

class _SphereCardState extends State<SphereCard> {
  CardOptions? selectedMenu;

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
                (widget.isLoading ?? false)
                    ? buildLoadingContainer(width: 100, colors: [EBColor.primary[400]!, EBColor.primary[300]!.withOpacity(0.5)])
                    : _buildFooterRow(
                        icon: const FaIcon(FontAwesomeIcons.bullhorn, size: 16),
                        text: widget.hasNewAnnouncements! ? 'New announcements' : 'No recent announcements',
                      ),
                const SizedBox(height: Spacing.sm),
                (widget.isLoading ?? false)
                    ? buildLoadingContainer(width: 50, colors: [EBColor.primary[400]!, EBColor.primary[300]!.withOpacity(0.5)])
                    : _buildFooterRow(
                        icon: const Icon(FeatherIcons.user, size: 16),
                        text: '${widget.numOfPeople} people',
                      ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EBButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(route: Routes.announcements, args: BarangayModel(name: widget.brgyName!, code: int.parse(widget.brgyCode!))));
                },
                text: 'View',
                theme: EBButtonTheme.primary,
                disabled: widget.disableButtons ?? false,
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
            Clipboard.setData(ClipboardData(text: widget.brgyCode!));
            ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: 'Brgy. sphere code has been copied to your clipboard.'));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemOne,
            height: 40,
            child: Text('Copy Code'),
          ),
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemTwo,
            height: 40,
            child: Text('Leave Barangay Sphere'),
          ),
          const PopupMenuItem<CardOptions>(
            value: CardOptions.itemThree,
            height: 40,
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
      decoration: const BoxDecoration(borderRadius: borderRadius),
      margin: const EdgeInsets.all(Global.paddingBody),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Column(
              children: [
                widget.cardHeader(),
                _cardFooter(),
              ],
            ),
            !(widget.isLoading ?? false) ? _cardOption() : Container(),
          ],
        ),
      ),
    );
  }
}
