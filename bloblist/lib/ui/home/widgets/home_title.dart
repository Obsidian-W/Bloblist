import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTitle extends StatefulWidget {
  final String defaultTitle;
  final void Function(String)? onTitleChanged;
  const HomeTitle({
    super.key,
    this.defaultTitle = 'Tamagoblob', // Default title if not set
    this.onTitleChanged, //Callback -> possibly notify server in viewmodel
  });

  @override
  State<HomeTitle> createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  late String _title;
  bool _editing = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.defaultTitle;
    _controller.text = _title;
    _loadTitle();
  }

  Future<void> _loadTitle() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _title = prefs.getString('home_title') ?? widget.defaultTitle;
      _controller.text = _title;
    });
  }

  Future<void> _saveTitle(String newTitle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('home_title', newTitle);
    setState(() {
      _title = newTitle;
      _editing = false;
    });
    widget.onTitleChanged?.call(newTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _editing
            ? Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  autofocus: true,
                  onSubmitted: _saveTitle,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                ),
              )
            : Expanded(
                child: Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        IconButton(
          icon: Icon(_editing ? Icons.check : Icons.edit),
          onPressed: () {
            if (_editing) {
              _saveTitle(_controller.text);
            } else {
              setState(() {
                _editing = true;
                _controller.text = _title;
              });
            }
          },
        ),
      ],
    );
  }
}
