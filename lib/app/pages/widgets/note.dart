// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/app/models/note_model.dart';
import 'package:notepad/app/pages/widgets/custom_rect_tween.dart';
import 'package:notepad/app/pages/widgets/hero_dialogue_route.dart';
import 'package:notepad/app/pages/widgets/todo_popup_card.dart';
import 'package:responsive/responsive.dart';

class Note extends StatelessWidget {
  NoteModel note;
  String heroAddTodo;
  Note({Key? key, required this.note, required this.heroAddTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return TodoPopupCard(
            heroAddTodo: heroAddTodo,
            isUpdateButton: true,
            note: note,
          );
        }));
      },
      child: Hero(
        tag: heroAddTodo,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          type: MaterialType.transparency,
          child: FlexWidget(
            xsOffset: 0,
            lgOffset: 0,
            xs: 13,
            sm: 6,
            md: 4,
            lg: 3,
            xsLand: 0,
            xsLandOffset: 0,
            smLand: 0,
            mdLand: 0,
            lgLand: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Card(
                color: const Color.fromARGB(255, 49, 51, 56),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20),
                  child: ListTile(
                    title: Text(
                      note.title!,
                      style: GoogleFonts.josefinSans(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        note.content!,
                        style: GoogleFonts.barlow(
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 190, 190, 190)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
