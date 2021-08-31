import 'package:app/database_helper.dart';
import 'package:app/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets.dart';

class RecipePage extends StatefulWidget {
  final Recipe? recipe;
  RecipePage({required this.recipe});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  int _recipeId = 0;
  String _recipeTitle = '';
  String _recipeDescription = '';

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.recipe != null) {
      _contentVisible = true;

      _recipeTitle = widget.recipe!.title!;
      //_recipeDescription = widget.recipe!.description!;
      _recipeId = widget.recipe!.id!;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();

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
                            if (widget.recipe == null) {
                              Recipe _newRecipe = Recipe(
                                title: value,
                              );
                              await _dbHelper.insertRecipe(_newRecipe);
                              setState(() {
                                _contentVisible = true;
                                _recipeTitle = value;
                              });
                            } else {
                              _dbHelper.updateRecipeTitle(_recipeId, value);
                            }
                            _descriptionFocus.requestFocus();
                          }
                        },
                        controller: TextEditingController()
                          ..text = _recipeTitle,
                        decoration: InputDecoration(
                          hintText: "Enter recipe title",
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
                      if (value != "") {
                        if (_recipeId != 0) {
                          await _dbHelper.updateRecipeDescription(
                              _recipeId, value);
                          _recipeDescription = value;
                        }
                      }
                    },
                    controller: TextEditingController()
                      ..text = _recipeDescription,
                    decoration: InputDecoration(
                      hintText: "Enter details of the recipe below...",
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
                        if (_recipeId != 0) {
                          await _dbHelper.deleteRecipe(_recipeId);
                          Navigator.pop(context);
                        }
                      },
                      child: DeleteShoppingListWidget(
                        deleteText: 'Remove the whole shopping list -',
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
