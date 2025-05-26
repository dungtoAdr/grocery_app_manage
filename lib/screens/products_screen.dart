import 'package:flutter/material.dart';
import 'package:grocery_manager_app/models/product.dart';
import 'package:grocery_manager_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final int id;

  const ProductsScreen({super.key, required this.id});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];
  List<Product> filterProducts = [];
  late final ProductProvider productProvider;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final priceController = TextEditingController();
  final weighedController = TextEditingController();
  final isNewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    void showsDialog(Product? product) {
      if (product != null) {
        nameController.text = product.name;
        imageController.text = product.image;
        priceController.text = product.price.toString();
        weighedController.text = product.weighed;
        isNewController.text = product.isNew.toString();
      } else {
        nameController.text = "";
        imageController.text = "";
        priceController.text = "";
        weighedController.text = "";
        isNewController.text = "";
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(product == null ? "Add Product" : "Update Product"),
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
                    controller: priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Price"),
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
                    controller: weighedController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Weighed"),
                    ),
                  ),
                  TextFormField(
                    controller: isNewController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Is New (0, 1)"),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  product == null
                      ? productProvider.addProduct(
                          Product(
                            name: nameController.text,
                            image: imageController.text,
                            weighed: weighedController.text,
                            price: double.parse(priceController.text),
                            category_id: widget.id,
                            isNew: isNewController.text == 1 ? true : false,
                          ),
                        )
                      : productProvider.updateProduct(
                          Product(
                            id: product.id,
                            name: nameController.text,
                            image: imageController.text,
                            weighed: weighedController.text,
                            price: double.parse(priceController.text),
                            category_id: widget.id,
                            isNew: isNewController.text == "1" ? true : false,
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
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              showsDialog(null);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Consumer<ProductProvider>(
          builder: (context, value, child) {
            products = value.products;
            filterProducts = products
                .where(
                  (element) =>
                      element.category_id.toString() == widget.id.toString(),
                )
                .toList();
            return ListView.builder(
              itemCount: filterProducts.length,
              itemBuilder: (context, index) {
                Product product = filterProducts[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(product.image, width: 50, height: 50),
                    title: Text(product.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showsDialog(product);
                          },
                          icon: Icon(Icons.auto_fix_high),
                        ),
                        IconButton(
                          onPressed: () async {
                            await productProvider.deleteProduct(product.id!);
                          },
                          icon: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
