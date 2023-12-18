import 'package:equatable/equatable.dart';
import 'package:ntodotxt/domain/todo/todo_model.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object?> get props => [];
}

final class TodoListSubscriptionRequested extends TodoListEvent {
  const TodoListSubscriptionRequested();
}

final class TodoListSynchronizationRequested extends TodoListEvent {
  const TodoListSynchronizationRequested();
}

final class TodoListTodoSubmitted extends TodoListEvent {
  final Todo todo;

  const TodoListTodoSubmitted({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

final class TodoListTodoDeleted extends TodoListEvent {
  final Todo todo;

  const TodoListTodoDeleted({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

final class TodoListTodoCompletionToggled extends TodoListEvent {
  final Todo todo;
  final bool completion;

  const TodoListTodoCompletionToggled({
    required this.todo,
    required this.completion,
  });

  @override
  List<Object?> get props => [todo, completion];
}

final class TodoListTodoSelectedToggled extends TodoListEvent {
  final Todo todo;
  final bool selected;

  const TodoListTodoSelectedToggled({
    required this.todo,
    required this.selected,
  });

  @override
  List<Object?> get props => [todo, selected];
}

final class TodoListSelectedAll extends TodoListEvent {
  const TodoListSelectedAll();
}

final class TodoListUnselectedAll extends TodoListEvent {
  const TodoListUnselectedAll();
}

final class TodoListSelectionCompleted extends TodoListEvent {
  const TodoListSelectionCompleted();
}

final class TodoListSelectionIncompleted extends TodoListEvent {
  const TodoListSelectionIncompleted();
}

final class TodoListSelectionDeleted extends TodoListEvent {
  const TodoListSelectionDeleted();
}
