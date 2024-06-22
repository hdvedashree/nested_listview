import 'dart:convert';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String json = '''
  {
    "hardware_categories": [
      {
        "name": "Computers",
        "subcategories": [
          {
            "name": "Laptops",
            "items": [
              {"name": "Apple MacBook Pro"},
              {"name": "Dell XPS 15"},
              {"name": "HP Spectre x360"},
              {"name": "Lenevo"}
            ]
          },
          {
            "name": "Desktops",
            "items": [
              {"name": "Apple iMac"},
              {"name": "Dell Inspiron"},
              {"name": "HP Pavilion"}
            ]
          }
        ]
      },
      {
        "name": "Mobile Devices",
        "subcategories": [
          {
            "name": "Smartphones",
            "items": [
              {"name": "iPhone 13"},
              {"name": "Samsung Galaxy S21"},
              {"name": "Google Pixel 6"}
            ]
          },
          {
            "name": "Tablets",
            "items": [
              {"name": "iPad Pro"},
              {"name": "Samsung Galaxy Tab S7"},
              {"name": "Microsoft Surface Pro"}
            ]
          }
        ]
      }
    ]
  }
  ''';

  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jsonData = jsonDecode(json);
    final hardwareCategories = jsonData['hardware_categories'];

    return ListView.builder(
      itemCount: hardwareCategories.length,
      itemBuilder: (context, index) {
        final category = hardwareCategories[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 0)
              Divider(
                color: Colors.grey[400],
                height: 1,
                thickness: 1,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                category['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ..._buildSubcategories(category['subcategories']),
          ],
        );
      },
    );
  }

  List<Widget> _buildSubcategories(List<dynamic> subcategories) {
    return subcategories.map((subcategory) {
      return _L2CategoryList(subcategory);
    }).toList();
  }
}

class _L2CategoryList extends StatelessWidget {
  final dynamic subcategory;

  const _L2CategoryList(this.subcategory);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey[400],
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            subcategory['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        ..._buildItems(subcategory['items']),
      ],
    );
  }

  List<Widget> _buildItems(List<dynamic> items) {
    return items.map((item) {
      return _L3CategoryList(item);
    }).toList();
  }
}

class _L3CategoryList extends StatelessWidget {
  final dynamic item;

  const _L3CategoryList(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add your onTap functionality here
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.category, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
