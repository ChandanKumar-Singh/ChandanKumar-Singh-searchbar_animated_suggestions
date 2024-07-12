Saas Test
Saas Test is a Flutter package that provides a customizable search field widget (SaasField) with animated suggestions. It includes a demo SaasTest widget showcasing its usage.

Installation
To use this package, add saas_test as a dependency in your pubspec.yaml file:

```yaml
Copy code
dependencies:
  saas_test:
    git:
      url: git://github.com/your_username/saas_test.git
```


## Usage
Import the package in your Dart file:

```dart
Copy code
import 'package:flutter/material.dart';
import 'package:saas_test/saas_test.dart';
```
Use the SaasField widget in your widget tree:

```dart
Copy code
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saas Test Demo'),
      ),
      body: SaasTest(), // Use the SaasTest widget here
    );
  }
}
```
# SaasTest Widget
The SaasTest widget demonstrates the usage of SaasField:

Displays a search bar (SaasField) with animated suggestions.
Shows a sample list of food items for search suggestions.
``` dart
Copy code
class SaasTest extends StatefulWidget {
  const SaasTest({Key? key}) : super(key: key);

  @override
  _SaasTestState createState() => _SaasTestState();
}

class _SaasTestState extends State<SaasTest> {
  void toast(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [
      "Chicken curry 🐔",
      "Egg curry 🥚",
      "Fish curry 🐟",
      "Paneer curry 🧀",
      "Heavy diet 🍔",
      "Mixed protein chat 🍲",
    ];

    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaasField(
              height: 50,
              items: items,
              showDivider: true,
              onSubmitted: (value) => toast(value),
              padding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: Colors.grey),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.filter_alt, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: Text(
              'Hello, Saas!',
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saas Test',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Here you can taste the Mohali best food',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

```
### Features
Search Bar (SaasField): Interactive search field with auto-animated suggestions.
Customization: Easily customize UI elements like icons, padding, and actions.
Usage: Ideal for displaying dynamic search suggestions in various applications.
License
This project is licensed under the MIT License - see the LICENSE file for details.