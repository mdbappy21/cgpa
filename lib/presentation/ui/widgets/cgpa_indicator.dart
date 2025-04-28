import 'package:flutter/material.dart';

class CgpaIndicator extends StatefulWidget {
  final double cgpa;

  const CgpaIndicator({super.key, required this.cgpa});

  @override
  State<CgpaIndicator> createState() => _CgpaIndicatorState();
}

class _CgpaIndicatorState extends State<CgpaIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.cgpa / 4.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  String getCgpaRemark(double cgpa) {
    if (cgpa == 4.0) {
      return "Outstanding";
    } else if (cgpa >= 3.75) {
      return "Excellent";
    } else if (cgpa >= 3.50) {
      return "Very Good";
    }else if (cgpa >= 3.25) {
      return "Good";
    }else if (cgpa >= 3) {
      return "Satisfactory";
    }else if (cgpa >= 2.70) {
      return "Above Average";
    }else if (cgpa >= 2.50) {
      return "Average";
    }else if (cgpa >= 2.25) {
      return "Bellow Average";
    }else if (cgpa >= 2) {
      return "Pass";
    } else {
      return "Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    final remark = getCgpaRemark(widget.cgpa); // Get remark text

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 2.3,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder:
                      (context, child) => CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade400,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CGPA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    widget.cgpa.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          remark,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
