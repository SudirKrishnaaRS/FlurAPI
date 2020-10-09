import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'entities/note.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  Widget appBarTitle = Row(
    children: <Widget>[
      Text(
        'Flur',
        style: TextStyle(
          color: H1Clr,
        ),
      ),
      Text(
        'API',
        style: TextStyle(
          color: H2Clr,
        ),
      ),
    ],
  );
  Icon actionIcon = new Icon(Icons.search);

  Widget cardContents(String label, String value) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: H3Clr, //Colors.grey.shade600
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          value,
          style: TextStyle(
            color: H2Clr, //Colors.grey.shade600
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBarBGClr,
            centerTitle: true,
            title: appBarTitle,
            actions: <Widget>[
              new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon =Icon(Icons.close,color: H2Clr,);
                      this.appBarTitle = TextField(
                        style: new TextStyle(
                          color:  H2Clr,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                            new Icon(Icons.search, color: H1Clr),
                            hintText: "Search...",
                            hintStyle: new TextStyle(color:  H1Clr)),
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = Row(
                        children: <Widget>[
                          Text(
                            'Flur',
                            style: TextStyle(
                              color: H1Clr,
                            ),
                          ),
                          Text(
                            'API',
                            style: TextStyle(
                              color: H2Clr,
                            ),
                          ),
                        ],
                      );
                    }
                  });
                },
              ),
            ]),
        body: Container(
          color: appBarBGClr,
          child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) {
              return Card(
                //shadowColor: Colors.black,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
                shape: RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(12.0)),
                //clipBehavior: Clip.antiAlias,
                elevation: 20.0,
                color: CardClr,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 32.0, left: 10.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://volvere.in/img/volvere_logo.webp'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              _notes[index].title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: H1Clr,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      cardContents("RegID:", _notes[index].id.toString()),
                      cardContents("Email:", _notes[index].email),
                      cardContents("Contact Number:", _notes[index].phone),
                      cardContents("Website:", _notes[index].website),
                    ],
                  ),
                ),
              );
            },
            itemCount: _notes.length,
          ),
        ));
  }
}