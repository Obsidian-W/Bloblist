import 'package:flutter/material.dart';
import 'package:bloblist/l10n/app_localizations.dart';

/// A simple todo list view that allows adding and checking items.
/// It has a maximum of 3 items, and items can be checked or unchecked.
/// I added it as a separate widget to keep the code organized and reusable.
class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final List<String> _todos = [];
  final List<bool> _checked = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.trim().isNotEmpty && _todos.length < 5) {
      setState(() {
        _todos.add(_controller.text.trim());
        _checked.add(false);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.textEnterTodo,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text(AppLocalizations.of(context)!.actionAdd),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // ListView inside a constrained height:
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_todos[index]),
                    value: _checked[index],
                    onChanged: (val) {
                      setState(() {
                        _checked[index] = val ?? false;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
