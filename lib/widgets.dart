import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "{Empty name}",
              style: TextStyle(
                color: Color(0xFF79902F),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 4.0,
              ),
              child: Text(
                desc ?? "{Empty description}",
                style: TextStyle(
                    color: Color(0xFF859063), fontSize: 14.0, height: 1.3),
              ),
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class TitleCardWidget extends StatelessWidget {
  String titleText;
  TitleCardWidget({required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: TextStyle(
                color: Color(0xFF79902F),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                'Get started by adding your first item!',
                style: TextStyle(
                    color: Color(0xFF859063), fontSize: 14.0, height: 1.3),
              ),
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class AddShoppingListWidget extends StatelessWidget {
  String? addText = '';
  AddShoppingListWidget({required this.addText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Color(0xFF79902F),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            addText!.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DeleteShoppingListWidget extends StatelessWidget {
  String? deleteText = '';
  DeleteShoppingListWidget({required this.deleteText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Color(0xFFcc0000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            deleteText!.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String product;
  final bool isDone;
  ProductWidget({
    required this.product,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Row(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            margin: EdgeInsets.only(
              right: 16.0,
            ),
            decoration: BoxDecoration(
              color: isDone ? Color(0xFFD3859F) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone
                  ? null
                  : Border.all(
                      color: Color(0xFFD3859F),
                      width: 1.5,
                    ),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          Flexible(
            child: Text(product,
                style: TextStyle(
                  color: isDone ? Color(0xFFD3859F) : Color(0xFFdda1b5),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
