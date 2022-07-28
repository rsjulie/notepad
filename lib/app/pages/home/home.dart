import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/app/models/note_model.dart';
import 'package:notepad/app/pages/home/home_controller.dart';
import 'package:notepad/app/pages/widgets/hero_dialogue_route.dart';
import 'package:notepad/app/pages/widgets/note.dart';
import 'package:notepad/app/pages/widgets/todo_popup_card.dart';
import 'package:notepad/app/provider/notepad_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  late List<NoteModel> notes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notes = Provider.of<NotepadProvider>(context).getnotes();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 34),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Image.asset('assets/images/logo.png', width: 200),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Notepad',
            style: GoogleFonts.dancingScript(
              letterSpacing: 1,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 30,
              shadows: [
                const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 2,
                    color: Color.fromARGB(255, 211, 211, 211)),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return TodoPopupCard(
                    heroAddTodo: "floatingActionButtonTag",
                  );
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return TodoPopupCard(heroAddTodo: "floatingActionButtonTag");
            }));
          },
          backgroundColor: const Color.fromARGB(255, 98, 0, 255),
          hoverColor: const Color.fromARGB(255, 43, 196, 23),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: ResponsiveRow(
          columnsCount: 13,
          spacing: 4,
          runAlignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (var i = 0; i < notes.length; i++)
              Note(
                note: notes[i],
                heroAddTodo: 'heroAddTodo$i',
              ),
          ],
        ),
      ),
    );
  }
}
