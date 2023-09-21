import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: 200,
                  color: Colors.white,
                  child: const Center(
                    child: Icon(
                      Icons.upload,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Upload Photo',
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  label: 'Add Report',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
