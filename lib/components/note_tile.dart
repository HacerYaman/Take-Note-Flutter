import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:take_note/components/note_settings.dart';

class NoteTileWidget extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTileWidget(
      {super.key,
      required this.text,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
          title: Text(text),
          trailing: Builder(
            builder: (context) => IconButton(
                onPressed: () => showPopover(
                  width: 100,
                    height: 100,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    context: context,
                    bodyBuilder: (context) => NoteSettings(
                          onEditTap: onEditPressed,
                          onDeleteTap: onDeletePressed,
                        )),
                icon: const Icon(Icons.more_vert)),
          )),
    );
  }
}
