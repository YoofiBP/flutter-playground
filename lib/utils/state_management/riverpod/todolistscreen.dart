import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class Todo {
  final String title;
  final bool completed;

  Todo({required this.completed, required this.title});
}

class TodoModel {
  final List<Todo> todos = [Todo(completed: false, title: 'Get COVID test')];

  void add(Todo todo) {
    todos.add(todo);
  }
}

final normalTodosProvider = StateProvider((ref) => TodoModel());

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([Todo(completed: false, title: 'Get COVID test')]);

  void add(Todo todo) {
    state = [...state, todo];
  }
}

final todosProvider =
    StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Widget child;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
            right: 4.0 + offset.dx,
            left: 4.0 + offset.dy,
            child: Transform.rotate(angle: (1.0 - progress.value) * pi / 2));
      },
      child: FadeTransition(
        child: child,
        opacity: progress,
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab(
      {Key? key,
      this.initialOpen,
      required this.distance,
      required this.children})
      : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250),
        value: _open ? 1.0 : 0.0,
        vsync: this);
    _expandAnimation = CurvedAnimation(
        parent: _controller,
        reverseCurve: Curves.easeOutQuad,
        curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildTapToCloseFab() => SizedBox(
        width: 56,
        height: 56,
        child: Center(
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildTapToOpenTab() => IgnorePointer(
        ignoring: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transformAlignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _open ? 0.7 : 1.0,
            _open ? 0.7 : 1.0,
            1.0,
          ),
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _open ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            child: FloatingActionButton(
              onPressed: _toggle,
              child: Icon(Icons.create),
            ),
          ),
        ),
      );

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(_ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i]));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenTab()
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) => Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        color: Colors.blue,
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      );
}

class TodoNewScreen extends ConsumerWidget {
  const TodoNewScreen({Key? key}) : super(key: key);

  static const routeName = '/newTodo';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todos = watch(todosProvider);
    // print(todoModel);
    return Scaffold(
      floatingActionButton: ExpandableFab(distance: 2, children: [
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.format_size),
        ),
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.insert_photo),
        ),
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.videocam),
        ),
      ]),
      appBar: AppBar(
        title: Text('Riverpod Todo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => CheckboxListTile(
                    title: Text(todos[index].title),
                    value: todos[index].completed,
                    onChanged: (_) {
                      context
                          .read(todosProvider.notifier)
                          .add(Todo(completed: true, title: 'Riverpod'));
                    })),
          )
        ],
      ),
    );
  }
}
