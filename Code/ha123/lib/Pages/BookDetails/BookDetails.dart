import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Pages/BookDetails/BookActionBtn.dart';
import 'package:meapsbook/Pages/BookDetails/HeaderWidget.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: primaryColor,
              child: Row(
                children: [
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "About book",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [

                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Category",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [

                    ],
                  ),
                  const SizedBox(height: 30),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
