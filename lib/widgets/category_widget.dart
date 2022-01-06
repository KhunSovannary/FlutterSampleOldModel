import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/models/category_model.dart';
import 'package:flutter_chabhuoy/repository/category_repository.dart';
import 'package:flutter_chabhuoy/screens/category_screen.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({@required this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final cateogoryRepository = Provider.of<CategoryRepository>(context);

    return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: data
              .map<Widget>((item) => InkWell(
                    onTap: () {
                      cateogoryRepository.fetchCategoryById(
                          categoryId: item.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                  categoryId: item.id,
                                  title: item.name,
                                )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Image.network(
                                item.imageName,
                                width: MediaQuery.of(context).size.width * 0.16,
                                height:
                                    MediaQuery.of(context).size.width * 0.16,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            item.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
