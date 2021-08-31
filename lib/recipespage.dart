import 'package:app/database_helper.dart';
import 'package:app/recipepage.dart';
import 'package:app/widgets.dart';
import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 21.0,
          ),
          color: Color(0xFFEAE2DD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0,
                ),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 150,
                ),
              ),
              TitleCardWidget(
                titleText: "Your recipes",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipePage(
                        recipe: null,
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: AddShoppingListWidget(addText: "Add a new recipe +"),
              ),
              Expanded(
                child: FutureBuilder(
                  initialData: [],
                  future: _dbHelper.getRecipes(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipePage(
                                  recipe: snapshot.data[index],
                                ),
                              ),
                            ).then(
                              (value) {
                                setState(() {});
                              },
                            );
                          },
                          child: TaskCardWidget(
                            title: snapshot.data[index].title,
                            desc: snapshot.data[index].description,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
