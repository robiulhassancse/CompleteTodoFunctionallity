import 'package:flutter/material.dart';
import 'package:todo/todo/add_new_todo_screen.dart';
import 'package:todo/todo/edit_todo_screen.dart';
import 'package:todo/todo/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todes',
        ),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context ){
                return AlertDialog(
                  title: const Text('Alert!!......',style: TextStyle(color: Colors.red,fontSize: 24),),
                  content: const Text('Do you want all delete todo list'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text('Cancle'),),
                    TextButton(onPressed: (){
                      todoList.clear();
                      setState(() {});
                      Navigator.pop(context);
                    }, child: const Text('Delete,All',),),
                  ],
                );
              });

            },
            icon: const Icon(
              Icons.playlist_remove,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add,
              size: 24,
            ),
          ),
        ],
      ),
      body: Visibility(
        visible: todoList.isNotEmpty,
        replacement: Center(child: Image.asset('assets/images/empty.png')),
        child: ListView.separated(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: (){
                  todoList[index].isDone =!todoList[index].isDone;
                  setState(() {});
                },
                leading:Container(
                  height: 30,
                  width: 30,
                  color: Colors.grey,
                  child: Visibility(
                    visible: todoList[index].isDone,
                    replacement: Icon(Icons.close,color: Colors.white,),
                    child: Icon(Icons.done,color: Colors.white,weight: 20,size: 30),
                  ),
                ),
                title: Text(todoList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todoList[index].description),
                    Text(
                      todoList[index].dateTime.toString(),
                    ),
                  ],
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Todo app'),
                                content: const Text('Do you want delete'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancle'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _removeTodo(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes,delete'),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                    IconButton(
                      onPressed: () => _onTabEditTodo(index),

                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //         title: const Text('Todo app'),
                      //         content: const Text('Do you want exit here'),
                      //         actions: [
                      //           TextButton(
                      //             onPressed: () {
                      //               Navigator.pop(context);
                      //             },
                      //             child: const Text('Cancle'),
                      //           ),
                      //           TextButton(
                      //             onPressed: () {},
                      //             child: const Text('Yes'),
                      //           ),
                      //         ],
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(11),
                      //         ),
                      //       );
                      //     });

                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 20,
                thickness: 2,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapTodoAddNewFAB(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onTapTodoAddNewFAB() async {
    final Todo? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTodoNewScreen(),
      ),
    );
    if (result != null) {
      todoList.add(result);
      setState(() {});
    }
  }

  Future<void> _onTabEditTodo(int index) async {
    final Todo? updatedTodo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTodoScreen(
          todo: todoList[index],
        ),
      ),
    );
    if (updatedTodo != null) {
      todoList[index] = updatedTodo;
      setState(() {});
    }
  }

  void _removeTodo(index) {
    todoList.removeAt(index);
    setState(() {});
  }
}
