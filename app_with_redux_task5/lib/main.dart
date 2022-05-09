import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';
import 'package:app_with_redux/redux/action.dart';
import 'package:app_with_redux/redux/reducer.dart';
import 'package:app_with_redux/model/item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redux Items',
        theme: ThemeData.light(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  bool buttonController = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.home_menu,
              progress: _animationController,
              semanticLabel: 'Menu',
            ), onPressed: () {
            buttonController ? _animationController.forward() : _animationController.reverse();
            buttonController = !buttonController;
          },
          ),
        ),
        backgroundColor: Colors.orange,
        title: const Text('Redux Items'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Column(
          children: <Widget>[
            AddItemWidget(viewModel),
            Expanded(child: ItemListWidget(viewModel)),
            RemoveItemsButton(viewModel),
          ],
        ),
      ),
    );
  }
}

class RemoveItemsButton extends StatelessWidget {
  final _ViewModel model;

  const RemoveItemsButton(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 200,
      height: 50,
      child: RaisedButton(
        color: Colors.orange,
        child: const Text('Delete all Items',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () => model.onRemoveItems(),
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final _ViewModel model;

  const ItemListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.items
          .map((Item item) =>
          Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    model.onRemoveItem(item);
                    },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
            title: Text(item.body),
          )
      ))
          .toList(),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  const AddItemWidget(this.model);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          fontSize: 15,
          color: Colors.black54,
        ),
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Add an item',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (String s) {
          widget.model.onAddItem(s);
          controller.text = '';
        },
      ),
    );
    
  }
}

class _ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  _ViewModel({
    required this.items,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onRemoveItems,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
    );
  }
}