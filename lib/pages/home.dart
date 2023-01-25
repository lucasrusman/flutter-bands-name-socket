import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Bon Jovi', votes: 2),
    Band(id: '4', name: 'Ciro y los persas', votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO: llamado al borrar server
      },
      background: Container(
          padding: const EdgeInsets.only(left: 8),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => print(band.name),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    print(Platform.isAndroid);
    if (Platform.isAndroid) {
      print(true);
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('New band name: '),
                content: TextField(
                  controller: textController,
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () => addBandToList(textController.text),
                    elevation: 5,
                    textColor: Colors.blue,
                    child: const Text('Add'),
                  )
                ],
              ));
    } else {
      return showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: const Text('New band name: '),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () => addBandToList(textController.text),
                    isDefaultAction: true,
                    child: const Text('Add'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    isDestructiveAction: true,
                    child: const Text('Dismiss'),
                  ),
                ],
              ));
    }
  }

  void addBandToList(String nombre) {
    print(nombre);
    if (nombre.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: nombre, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
