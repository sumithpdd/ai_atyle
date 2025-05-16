import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  final String colorType;
  final String styleType;
  final String bodyType;
  final bool outfitMatch;

  const AnalysisScreen({
    Key? key,
    required this.colorType,
    required this.styleType,
    required this.bodyType,
    required this.outfitMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Color Type: $colorType', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Style Type: $styleType', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Body Type: $bodyType', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'Outfit Match: ${outfitMatch ? "Yes" : "No"}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
