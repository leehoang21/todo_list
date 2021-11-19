import 'package:flutter/material.dart';
import 'package:todo_list/cong_viec.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _daBamNutXoa = false;
  final List<CongViec> _listCongViec = [];
  List<int> _listCongViecCanXoa = [];
  final TextEditingController _myControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _daBamNutXoa = !_daBamNutXoa;
                });
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text('To-Do List'),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < _listCongViec.length; i++) hienThiCongViec(i)
        ],
      ),
      floatingActionButton: add(context),
      bottomNavigationBar: _daBamNutXoa ? hienThiNutXoa() : null,
    );
  }

  Widget hienThiCongViec(int i) {
    return _daBamNutXoa
        ? CheckboxListTile(
            title: textCongViec(i),
            value: _listCongViec[i].check,
            onChanged: (_) {
              setState(() {
                _listCongViec[i].check = !_listCongViec[i].check;
                if (_listCongViec[i].check) _listCongViecCanXoa.add(i);
              });
            },
          )
        : textCongViec(i);
  }

  Text textCongViec(int i) {
    return Text(
      _listCongViec[i].congViec,
      style: const TextStyle(
        fontSize: 25,
      ),
    );
  }

  void listCongViec() {
    CongViec cv = CongViec();
    cv.congViec = _myControler.text;
    _listCongViec.add(cv);
  }

  FloatingActionButton add(context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          hienThiDiaLog(context);
        });
      },
      child: const Icon(Icons.add),
    );
  }

  hienThiNutXoa() {
    return BottomAppBar(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (var i in _listCongViecCanXoa) {
              _listCongViec.removeAt(i);
            }
            _listCongViecCanXoa = [];
          });
        },
        child: const Text('xóa'),
      ),
    );
  }

  hienThiDiaLog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('nhập công việc'),
          content: Column(
            children: [
              TextField(
                controller: _myControler,
                decoration:
                    const InputDecoration(hintText: 'nhập công việc vào đây'),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      listCongViec();
                    });
                  },
                  child: const Text('thêm công việc'))
            ],
          ),
        );
      },
    );
  }
}
