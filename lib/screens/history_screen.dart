import 'package:flutter/material.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/constants/custom_font_weight.dart';
import 'package:sih_hackathon/constants/routes_data.dart';
import 'package:sih_hackathon/screens/plot_screen.dart';
import 'package:sih_hackathon/widgets/custom_text.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: const CustomText(
          content: "Travel History",
          fontWeight: CustomFontWeight.semibold,
          fontSize: 24,
          fontColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
          itemCount: travelHistory.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final route = travelHistory[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: Text(
                  route.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildRouteDetail(
                      icon: Icons.play_arrow_rounded,
                      label: "Start",
                      value: route.startName,
                    ),
                    const SizedBox(height: 4),
                    _buildRouteDetail(
                      icon: Icons.stop_rounded,
                      label: "End",
                      value: route.endName,
                    ),
                    const SizedBox(height: 4),
                    _buildRouteDetail(
                      icon: Icons.attach_money_rounded,
                      label: "Expenses",
                      value: "${route.expenses}", // Assuming Indian Rupees
                    ),
                  ],
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
                onTap: () {
                  // Navigate to the PlotScreen with the selected route
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlotScreen(route: route),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to create consistent route detail rows
  Widget _buildRouteDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: "$label: ",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
