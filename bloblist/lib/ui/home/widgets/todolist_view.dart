import 'package:bloblist/ui/all.dart';
import 'package:flutter/material.dart';
import 'package:bloblist/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final TextEditingController _controller = TextEditingController();

  List<String> _allTasksFromJson = []; //While typing, this will hold the filtered tasks
  List<String> _filteredTasks = []; //While typing, this will hold the filtered tasks

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    _allTasksFromJson = vm.tasksFromJson; // Get all tasks from JSON

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.textEnterTodo,
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addTask(context, vm),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _addTask(context, vm),
                child: Text(AppLocalizations.of(context)!.actionAdd),
              ),
            ],
          ),
          if (_filteredTasks.isNotEmpty)
            Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredTasks.length,
                itemBuilder: (context, index) {
                  final suggestion = _filteredTasks[index];
                  return ListTile(title: Text(suggestion), onTap: () => _selectSuggestion(suggestion));
                },
              ),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: vm.tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    vm.tasks[index].taskName,
                    style: TextStyle(
                      decoration: vm.tasks[index].completed ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  value: vm.tasks[index].completed,
                  onChanged: vm.tasks[index].completed ? null : (_) => vm.toggleTask(index),
                  checkColor: Colors.white,
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.deepPurple;
                    }
                    return Colors.transparent;
                  }),
                  side: WidgetStateBorderSide.resolveWith((states) {
                    return BorderSide(color: Colors.deepPurple, width: 2);
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChanged() {
    final input = _controller.text.toLowerCase();
    setState(() {
      if (input.isEmpty) {
        _filteredTasks = [];
      } else {
        _filteredTasks = _allTasksFromJson.where((task) => task.toLowerCase().contains(input)).toList();
      }
    });
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    setState(() {
      _filteredTasks = [];
    });
    // Optionally move cursor to end:
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  Future<void> _addTask(BuildContext context, HomeViewModel homeViewModel) async {
    if (_controller.text.trim().isEmpty) {
      //Can't add an empty task
      return;
    }
    final success = await homeViewModel.addTask(_controller.text);
    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.alertTodoLimit)));
    } else {
      _controller.clear();
    }
  }
}
