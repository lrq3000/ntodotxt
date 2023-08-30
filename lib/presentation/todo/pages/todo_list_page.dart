import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ntodotxt/common_widgets/app_bar.dart';
import 'package:ntodotxt/common_widgets/chip.dart';
import 'package:ntodotxt/common_widgets/fab.dart';
import 'package:ntodotxt/common_widgets/filter_dialog.dart';
import 'package:ntodotxt/common_widgets/group_by_dialog.dart';
import 'package:ntodotxt/common_widgets/order_dialog.dart';
import 'package:ntodotxt/constants/screen.dart';
import 'package:ntodotxt/domain/todo/todo_model.dart';
import 'package:ntodotxt/presentation/todo/pages/todo_search_page.dart';
import 'package:ntodotxt/presentation/todo/states/todo_list.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < maxScreenWidthCompact) {
      return const TodoListNarrowView();
    } else {
      return const TodoListWideView();
    }
  }
}

abstract class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  /// Add new todo
  void _createAction(BuildContext context) {
    context.push(context.namedLocation('todo-create'));
  }

  /// Switch todo list ordering.
  void _orderAction(BuildContext context) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => const OrderDialog(),
    );
  }

  /// Switch todo list filter.
  void _filterAction(BuildContext context) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => const FilterDialog(),
    );
  }

  /// Switch todo group by view.
  void _groupByAction(BuildContext context) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) => const GroupByDialog(),
    );
  }

  List<Widget> _buildToolBarActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Group by',
        icon: const Icon(Icons.view_list),
        onPressed: () => _groupByAction(context),
      ),
      IconButton(
        tooltip: 'Sort',
        icon: const Icon(Icons.sort_by_alpha),
        onPressed: () => _orderAction(context),
      ),
      IconButton(
        tooltip: 'Filter',
        icon: const Icon(Icons.filter_alt),
        onPressed: () => _filterAction(context),
      ),
      IconButton(
        tooltip: 'Search',
        icon: const Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: TodoSearchPage(),
          );
        },
      ),
    ];
  }
}

class TodoListNarrowView extends TodoListView {
  const TodoListNarrowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "All todos",
        leadingAction: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: const TodoList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: PrimaryBottomAppBar(
        children: _buildToolBarActions(context),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return PrimaryFloatingActionButton(
      icon: const Icon(Icons.add),
      tooltip: 'Add',
      action: () => _createAction(context),
    );
  }
}

class TodoListWideView extends TodoListView {
  const TodoListWideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        ..._buildToolBarActions(context),
        const SizedBox(width: 16.0),
      ]),
      body: const TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (BuildContext context, TodoListState state) {
        // @todo: SingleChildScrollView
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: _buildExpandedListViewByFilter(state: state),
              ),
            ),
          ],
        );
      },
    );
  }

  List<TodoListSection> _buildExpandedListViewByFilter({
    required TodoListState state,
  }) {
    List<TodoListSection> items = [];
    for (var section in state.groupedByTodoList.keys) {
      final Iterable<Todo>? todoList = state.groupedByTodoList[section];
      if (todoList != null) {
        items.add(
          TodoListSection(
            title: section,
            children: [
              for (var todo in todoList) TodoTile(todo: todo),
            ],
          ),
        );
      }
    }

    return items;
  }
}

class TodoListSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  TodoListSection({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: PageStorageKey<String>(title));

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: key,
      initiallyExpanded: true,
      shape: Border(
        bottom: BorderSide(
          color: DividerTheme.of(context).color!,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      children: children,
    );
  }
}

class TodoTile extends StatelessWidget {
  final Todo todo;

  TodoTile({
    required this.todo,
    Key? key,
  }) : super(key: PageStorageKey<int>(todo.id!));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      leading: Checkbox(
        value: todo.completion,
        onChanged: (bool? completion) {
          context.read<TodoListBloc>().add(
                TodoListTodoCompletionToggled(
                  todo: todo,
                  completion: completion ?? false,
                ),
              );
        },
      ),
      title: Text(todo.description),
      subtitle: _buildSubtitle(),
      onTap: () => _onTapAction(context),
    );
  }

  Widget? _buildSubtitle() {
    if (todo.projects.isEmpty &&
        todo.contexts.isEmpty &&
        todo.keyValues.isEmpty) {
      return null;
    }

    return GenericChipGroup(
      children: <Widget>[
        for (var p in todo.formattedProjects) Text(p),
        for (var c in todo.formattedContexts) Text(c),
        for (var kv in todo.formattedKeyValues) Text(kv),
      ],
    );
  }

  void _onTapAction(BuildContext context) {
    context.pushNamed("todo-view", extra: todo);
  }
}
