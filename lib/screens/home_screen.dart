import 'package:flutter/material.dart';
import 'package:grocery_manager_app/models/category.dart';
import 'package:grocery_manager_app/providers/category_provider.dart';
import 'package:grocery_manager_app/screens/products_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final colorController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    colorController.dispose();
    imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showsDialog(Category? category) {
      if (category != null) {
        nameController.text = category.name;
        imageController.text = category.image;
        colorController.text = category.color.toString();
      } else {
        nameController.text = "";
        colorController.text = "";
        imageController.text = "";
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(category == null ? "Add Category" : "Update Category"),
            content: Form(
              key: _formKey,
              child: Column(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Name"),
                    ),
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Image"),
                    ),
                  ),
                  TextFormField(
                    controller: colorController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Color"),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  category == null
                      ? Provider.of<CategoryProvider>(
                          context,
                          listen: false,
                        ).addCategory(
                          Category(
                            name: nameController.text,
                            image: imageController.text,
                            color: int.parse(colorController.text),
                          ),
                        )
                      : Provider.of<CategoryProvider>(
                          context,
                          listen: false,
                        ).updateCategory(
                          Category(
                            id: category.id,
                            name: nameController.text,
                            image: imageController.text,
                            color: int.parse(colorController.text),
                          ),
                        );
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Danh mục"),),
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          List<Category> categories = Provider.of<CategoryProvider>(
            context,
            listen: false,
          ).categories;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(id: category.id!),
                  ),
                ),
                child: Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => showsDialog(category),
                          icon: Icon(Icons.auto_fix_high),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<CategoryProvider>(
                              context,
                              listen: false,
                            ).deleteCategory(category.id!);
                          },
                          icon: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showsDialog(null),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
