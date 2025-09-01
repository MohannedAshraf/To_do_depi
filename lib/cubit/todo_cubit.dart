import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState.initial);

  void addTodo(String title, String description) {
    if (title.trim().isEmpty) {
      emit(state.copyWith(error: 'You cant add empty Todo!'));
      return;
    }

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
    );

    final currentTodos = _getCurrentTodos();
    emit(state.success([...currentTodos, newTodo]));
  }

  void deleteTodo(String id) {
    final currentTodos = _getCurrentTodos();
    emit(
      state.copyWith(
        todos: currentTodos.where((todo) => todo.id != id).toList(),
        status: TodoStatus.success,
      ),
    );
  }

  void toggleTodo(String id) {
    final currentTodos = _getCurrentTodos();
    emit(
      state.copyWith(
        status: TodoStatus.success,
        todos:
            currentTodos.map((todo) {
              if (todo.id == id) {
                return todo.copyWith(isCompleted: !todo.isCompleted);
              }
              return todo;
            }).toList(),
      ),
    );
  }

  List<Todo> _getCurrentTodos() {
    return state.todos;
  }
}
