import 'package:flutter/material.dart';
import 'package:searchbar_animated_suggestions/searchbar_animated_suggestions.dart';

class SaasTest extends StatefulWidget {
  const SaasTest({super.key});

  @override
  State<SaasTest> createState() => _SaasTestState();
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
      appBar: appbar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaasField(
              height: 50,
              items: items,
              elevation: 0.5,
              showDivider: true,
              onSubmitted: (value) => toast(value),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
              prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: Colors.grey)),
              actions: [
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.filter_alt, color: Colors.grey),
                  ),
                ),
                // InkWell(
                //     onTap: () {},
                //     child: const Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Icon(Icons.sort),
                //     )),
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

  AppBar appbar() {
    return AppBar(
      title: const Column(
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
