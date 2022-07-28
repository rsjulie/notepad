import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notepad/app/models/note_model.dart';
import 'package:notepad/app/pages/widgets/custom_rect_tween.dart';
import 'package:notepad/app/provider/notepad_provider.dart';
import 'package:provider/provider.dart';

class TodoPopupCard extends StatefulWidget {
  NoteModel? note;
  String heroAddTodo;
  bool isUpdateButton;

  /// {@macro add_todo_popup_card}
  TodoPopupCard(
      {Key? key,
      required this.heroAddTodo,
      this.note,
      this.isUpdateButton = false})
      : super(key: key);

  @override
  State<TodoPopupCard> createState() => _TodoPopupCardState();
}

class _TodoPopupCardState extends State<TodoPopupCard> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    setState(() {
      titleController.text = widget.note?.title ?? '';
      contentController.text = widget.note?.content ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      log(widget.note!.id.toString());
      log(widget.note!.title.toString());
      log(widget.note!.content.toString());
    }
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: widget.heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: const Color.fromARGB(255, 57, 59, 65),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                      cursorColor: const Color.fromARGB(255, 116, 116, 116),
                      style: GoogleFonts.josefinSans(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    TextField(
                      controller: contentController,
                      style: GoogleFonts.barlow(
                          fontSize: 16,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 190, 190, 190)),
                      decoration: const InputDecoration(
                          hintText: 'Type something...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Color.fromARGB(255, 134, 134, 134),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: widget.note != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          if (widget.note != null)
                            Text(
                              DateFormat.yMMMEd()
                                  .format(widget.note!.createdAt),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (widget.note != null)
                                  TextButton.icon(
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Color.fromARGB(255, 209, 114, 114),
                                    ),
                                    onPressed: () {
                                      Provider.of<NotepadProvider>(context,
                                              listen: false)
                                          .deleteNote(widget.note!.id!);
                                      Navigator.pop(context);
                                    },
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 209, 114, 114)),
                                    ),
                                  ),
                                const SizedBox(width: 15),
                                TextButton.icon(
                                  icon: Icon(
                                    widget.note != null
                                        ? Icons.save
                                        : Icons.check,
                                    color: const Color.fromARGB(
                                        255, 194, 177, 255),
                                  ),
                                  onPressed: () {
                                    if (widget.note != null) {
                                      log(widget.note!.title.toString());
                                    } else {
                                      NoteModel newNote = NoteModel();
                                      if (titleController.text != '') {
                                        newNote.title = titleController.text;
                                      }
                                      if (contentController.text != '') {
                                        newNote.content =
                                            contentController.text;
                                      }

                                      Provider.of<NotepadProvider>(context,
                                              listen: false)
                                          .addNote(newNote);
                                      Navigator.pop(context);
                                    }
                                  },
                                  label: Text(
                                    widget.isUpdateButton ? 'Save' : 'Create',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 194, 177, 255)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
