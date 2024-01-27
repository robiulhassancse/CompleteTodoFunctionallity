import 'package:flutter/material.dart';
import 'package:todo/todo/todo.dart';

class AddNewTodoNewScreen extends StatefulWidget {
  @override
  State<AddNewTodoNewScreen> createState() => _AddNewTodoNewScreenState();
}

class _AddNewTodoNewScreenState extends State<AddNewTodoNewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title ';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                  // label: Text('Title'),
                  prefixIcon: Icon(
                    Icons.account_circle_rounded,
                    size: 26,
                  ),
                  prefixIconColor: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionTEController,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your description';
                  }
                  return null;
                },
                maxLines: 5,
                maxLength: 1000,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  // label: Text('Description'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    )),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo todo = Todo(
                          _titleTEController.text.trim(),
                          _descriptionTEController.text.trim(),
                          DateTime.now(),
                          false,
                        );
                        Navigator.pop(context, todo);
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
