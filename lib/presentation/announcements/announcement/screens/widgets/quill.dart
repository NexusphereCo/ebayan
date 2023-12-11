import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

class RenderRichTextArea extends StatelessWidget {
  const RenderRichTextArea({
    super.key,
    required this.bodyController,
  });

  final QuillController bodyController;

  // Editor configuration...
  QuillEditorConfigurations editorConfigurations() {
    return QuillEditorConfigurations(
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
          TextStyle(
            fontFamily: EBTypography.fontFamily,
            fontWeight: EBFontWeight.regular,
            fontSize: EBFontSize.label,
            color: EBColor.dark.withOpacity(0.5),
          ),
          const VerticalSpacing(0.0, 0.0),
          const VerticalSpacing(1.0, 1.0),
          BoxDecoration(
            border: Border.all(width: 3.0),
          ),
        ),
      ),
      minHeight: 250,
      readOnly: false,
      maxHeight: 500,
      padding: const EdgeInsets.all(Global.paddingBody),
      placeholder: 'Announce something to your barangay sphere',
      textCapitalization: TextCapitalization.sentences,
    );
  }

  // Allowed formatting buttons to show are modified here...
  QuillToolbarConfigurations toolbarConfiguration() {
    return const QuillToolbarConfigurations(
      showBoldButton: true,
      showItalicButton: true,
      showUnderLineButton: true,
      showListBullets: true,
      showUndo: true,
      showRedo: true,
      toolbarIconCrossAlignment: WrapCrossAlignment.start,
      // ----------
      showDividers: false,
      showFontFamily: false,
      showFontSize: false,
      showSmallButton: false,
      showStrikeThrough: false,
      showInlineCode: false,
      showColorButton: false,
      showBackgroundColorButton: false,
      showClearFormat: false,
      showAlignmentButtons: false,
      showLeftAlignment: false,
      showCenterAlignment: false,
      showRightAlignment: false,
      showJustifyAlignment: false,
      showHeaderStyle: false,
      showListNumbers: false,
      showListCheck: false,
      showCodeBlock: false,
      showQuote: false,
      showIndent: false,
      showLink: false,
      showDirection: false,
      showSearchButton: false,
      showSubscript: false,
      showSuperscript: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: bodyController,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('de'),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: EBColor.dark, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuillEditor.basic(configurations: editorConfigurations()),
            QuillToolbar(configurations: toolbarConfiguration()),
          ],
        ),
      ),
    );
  }
}
