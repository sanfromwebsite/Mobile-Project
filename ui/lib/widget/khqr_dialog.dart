import 'dart:async';
import 'package:flutter/material.dart';

class KHQRDialog extends StatefulWidget {
  const KHQRDialog({super.key});

  @override
  State<KHQRDialog> createState() => _KHQRDialogState();
}

class _KHQRDialogState extends State<KHQRDialog> {
  bool _isSuccess = false;
  Timer? _timer;
  int _secondsRemaining = 15; // 15 seconds to simulate bank processing

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    // Simulate "Checking for payment..." every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        // Payment "Received" from Bank
        if (mounted) {
          setState(() {
            _isSuccess = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isSuccess ? _buildSuccessState() : _buildWaitingState(),
        ),
      ),
    );
  }

  Widget _buildWaitingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: const ValueKey('waiting'),
      children: [
        const Text(
          "ស្កេនដើម្បីទូទាត់", // Scan to Pay
          style: TextStyle(
            fontFamily: 'Hanuman',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF5a7335),
          ),
        ),
        const SizedBox(height: 20),
        
        // QR Code
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/images/image.png',
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
        
        const SizedBox(height: 10),
        const Text(
          "KHQR",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        
        const SizedBox(height: 25),
        
        // Polling Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF5a7335)),
            ),
            const SizedBox(width: 15),
            Flexible(
              child: Text(
                "កំពុងផ្ទៀងផ្ទាត់ការទូទាត់... ($_secondsRemaining)", // Verifying payment...
                style: TextStyle(
                  fontFamily: 'Hanuman',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 5),
        Text(
          "សូមស្កេនឥឡូវនេះ (Please scan now)",
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),

        const SizedBox(height: 20),
        
        // Cancel Button
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "បោះបង់ (Cancel)",
            style: TextStyle(color: Colors.red, fontFamily: 'Hanuman'),
          ),
        )
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: const ValueKey('success'),
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF5a7335).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: Color(0xFF5a7335), size: 60),
        ),
        const SizedBox(height: 20),
        const Text(
          "ការទូទាត់ជោគជ័យ", // Payment Successful
          style: TextStyle(
            fontFamily: 'Hanuman',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF5a7335),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "ទទួលបានការទូទាត់ពីធនាគារ", // Payment received from bank
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Hanuman',
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5a7335),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              "រួចរាល់ (Done)",
              style: TextStyle(
                fontFamily: 'Hanuman',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
