import 'package:app/database_helper.dart';
import 'package:app/model/product.dart';
import 'package:app/model/shoppinglist.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets.dart';

class ShoppingListPage extends StatefulWidget {
  final ShoppingList? list;
  ShoppingListPage({required this.list});

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  int _listId = 0;
  String _listTitle = '';
  String _listDescription = '';

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _productFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.list != null) {
      _contentVisible = true;

      _listTitle = widget.list!.title!;
      //_listDescription = widget.list!.description!;
      _listId = widget.list!.id!;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _productFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _productFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 4.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _titleFocus,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (widget.list == null) {
                              ShoppingList _newList = ShoppingList(
                                title: value,
                              );
                              _listId = await _dbHelper.insertList(_newList);
                              setState(() {
                                _contentVisible = true;
                                _listTitle = value;
                              });
                            } else {
                              _dbHelper.updateListTitle(_listId, value);
                            }
                            _descriptionFocus.requestFocus();
                          }
                        },
                        controller: TextEditingController()..text = _listTitle,
                        decoration: InputDecoration(
                          hintText: "Enter shopping list title",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD3859F),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: TextField(
                    focusNode: _descriptionFocus,
                    onSubmitted: (value) async {
                      _productFocus.requestFocus();
                      if (value != "") {
                        if (_listId != 0) {
                          await _dbHelper.updateListDescription(_listId, value);
                          _listDescription = value;
                        }
                      }
                    },
                    controller: TextEditingController()
                      ..text = _listDescription,
                    decoration: InputDecoration(
                      hintText:
                          "Enter description of the shopping list below...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: GestureDetector(
                      onTap: () async {
                        if (_listId != 0) {
                          await _dbHelper.deleteList(_listId);
                          Navigator.pop(context);
                        }
                      },
                      child: DeleteShoppingListWidget(
                        deleteText: 'Remove the whole shopping list -',
                      )),
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: FutureBuilder(
                  initialData: [],
                  future: _dbHelper.getProducts(_listId),
                  builder: (context, AsyncSnapshot snapshot) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              //change stodo
                              if (snapshot.data[index].isDone == 0) {
                                await _dbHelper.updateProductIsDone(
                                    snapshot.data[index].id, 1);
                              } else {
                                await _dbHelper.updateProductIsDone(
                                    snapshot.data[index].id, 0);
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                              ),
                              child: ProductWidget(
                                product: snapshot.data[index].title,
                                isDone: snapshot.data[index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: TextField(
                      focusNode: _productFocus,
                      controller: TextEditingController()..text = '',
                      onSubmitted: (value) async {
                        if (value != "") {
                          if (_listId != 0) {
                            DatabaseHelper _dbHelper = DatabaseHelper();
                            Product _newProduct = Product(
                              title: value,
                              isDone: 0,
                              listId: _listId,
                            );
                            await _dbHelper.insertProduct(_newProduct);
                            setState(() {});
                            _productFocus.requestFocus();
                          }
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter product...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
