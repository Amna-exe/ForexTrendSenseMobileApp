import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class SentimentScreen extends StatefulWidget {
  const SentimentScreen({super.key});

  @override
  _SentimentScreenState createState() => _SentimentScreenState();
}

class _SentimentScreenState extends State<SentimentScreen> {
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  Map<String, int> sentimentData = {};

  @override
  void initState() {
    super.initState();
    fetchSentimentData();
  }

  Future<void> fetchSentimentData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/sentiment/report'));

      if (response.statusCode == 200) {
        setState(() {
          sentimentData = Map<String, int>.from(json.decode(response.body));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load sentiment data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentiment Analysis'),
        backgroundColor: const Color(0xFF3C096C),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $errorMessage', style: TextStyle(color: Colors.red, fontSize: 16)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            hasError = false;
                          });
                          fetchSentimentData();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: sentimentData['positive']?.toDouble() ?? 0,
                          title: 'Positive',
                          radius: 50,
                        ),
                        PieChartSectionData(
                          color: Colors.blue,
                          value: sentimentData['neutral']?.toDouble() ?? 0,
                          title: 'Neutral',
                          radius: 50,
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: sentimentData['negative']?.toDouble() ?? 0,
                          title: 'Negative',
                          radius: 50,
                        ),
                      ],
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
    );
  }
}
