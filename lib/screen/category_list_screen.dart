import 'package:api_practice01/data/model/category_page.dart';
import 'package:api_practice01/data/repository/api_service.dart';
import 'package:flutter/material.dart';

class CetagoryListScreen extends StatefulWidget {
  const CetagoryListScreen({super.key});

  @override
  State<CetagoryListScreen> createState() => _CetagoryListScreenState();
}

class _CetagoryListScreenState extends State<CetagoryListScreen> {
  late Future<Categories> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = ApiService().fetchCetagories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Item List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Categories>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Categories categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            categories.categories[index].strCategoryThumb,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              categories.categories[index].strCategory,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8),
                          child: Text(categories.categories[index].strCategoryDescription,style: TextStyle(color: Colors.black54,fontSize: 15),),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No categories found.'));
          }
        },
      ),
    );
  }
}
