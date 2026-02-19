import 'package:flutter/material.dart';
// import 'payment_detail.dart'; // Removed as per requested deletion of Invoice UI
import 'address_edit_page.dart';
import 'khqr_dialog.dart';
import 'map_picker_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../l10n/language_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isSummaryExpanded = false; // Persistent state for order summary visibility
  // Mock Data
  final List<Map<String, dynamic>> _cartItems = [
    {
      "title": "The Story of Heidi",
      "author": "Johanna Spyri",
      "price": 0.10,
      "image": Icons.book,
      "color": Colors.lightBlue.shade100,
      "quantity": 1,
    },
    {
      "title": "Positive Mindset",
      "author": "Jason Wolbers",
      "price": 0.10,
      "image": Icons.book,
      "color": Colors.orange.shade100,
      "quantity": 2,
    },
    {
      "title": "Success",
      "author": "Mr. Richard",
      "price": 0.10,
      "image": Icons.book,
      "color": Colors.yellow.shade100,
      "quantity": 1,
    },
  ];

  // Delivery Methods
  String _selectedDelivery = "J&T";
  final List<Map<String, dynamic>> _deliveryOptions = [
    {
      "id": "J&T",
      "name": "J&T Express",
      "desc": "Regular Delivery",
      "price": 1.50,
      "duration": "1-2 Days",
      "image": "assets/images/j&t.jpg",
      "color": Colors.red,
    },
    {
      "id": "VET",
      "name": "Vireak Buntham",
      "desc": "Standard Delivery",
      "price": 1.00,
      "duration": "2-3 Days",
      "image": "assets/images/vet.png",
      "color": Colors.blue,
    },
    {
      "id": "CAPITOL",
      "name": "Capitol Tours",
      "desc": "Economy Save",
      "price": 0.80,
      "duration": "3-5 Days",
      "icon": Icons.home_work_outlined,
      "color": Colors.orange,
    }
  ];

  // Address State
  String _address = "Locating..."; // Default while loading
  String _phone = "012 345 678";
  double? _lat;
  double? _lng;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
         _setDefaultAddress();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
           _setDefaultAddress();
           return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
         _setDefaultAddress();
         return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      // Check if location is inside Cambodia
      if (position.latitude < 9.9 || position.latitude > 14.7 || 
          position.longitude < 102.3 || position.longitude > 107.8) {
         _setDefaultAddress();
         // Silently fail to default address for better UX
      } else {
        _getAddressFromLatLng(position.latitude, position.longitude);
      }
      
    } catch (e) {
      debugPrint("Error getting location: $e");
       _setDefaultAddress();
    }
  }

  void _setDefaultAddress() {
    if (!mounted) return;
    setState(() {
      _address = "ផ្ទះលេខ ១២៣, ផ្លូវ ៤៥៦, រាជធានីភ្នំពេញ"; // Default Phnom Penh address
      _lat = 11.5564;
      _lng = 104.9282;
      _isLoadingLocation = false;
    });
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if (mounted) {
          setState(() {
            _address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
            _lat = lat;
            _lng = lng;
            _isLoadingLocation = false;
          });
        }
      } else {
        _setDefaultAddress();
      }
    } catch (e) {
      debugPrint("Geocoding error: $e");
      _setDefaultAddress();
    }
  }

  // ... (existing getters)

  // ... (existing builds)

  Widget _buildDeliveryHeader() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      color: theme.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: InkWell(
        onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressEditPage(
                  initialAddress: _address,
                  initialPhone: _phone,
                  initialDeliveryMethod: _selectedDelivery,
                ),
              ),
            );

            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                _address = result['address'];
                _phone = result['phone'];
                if (result['deliveryMethod'] != null) {
                   _selectedDelivery = result['deliveryMethod'];
                }
              });
            }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF5a7335).withOpacity(0.08), // Light green tint
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF5a7335).withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Color(0xFF5a7335)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LanguageService().translate('delivery_to'),
                          style: const TextStyle(
                            fontFamily: 'Hanuman',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _isLoadingLocation 
                          ? SizedBox(
                              height: 15, 
                              width: 15, 
                              child: CircularProgressIndicator(strokeWidth: 2, color: theme.textTheme.bodyLarge?.color)
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Hanuman',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                ),
                                if (_lat != null && _lng != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      "Lat: ${_lat!.toStringAsFixed(6)}, Lng: ${_lng!.toStringAsFixed(6)}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit_rounded, color: Colors.grey, size: 20),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1),
              ),
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPickerPage()),
                  );
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      _address = result['address'];
                      if (result['latitude'] != null && result['longitude'] != null) {
                         _lat = result['latitude'];
                         _lng = result['longitude'];
                      }
                    });
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.map_outlined, color: Color(0xFF5a7335), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      LanguageService().translate('choose_on_map'),
                      style: const TextStyle(
                        fontFamily: 'Hanuman',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5a7335),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right_rounded, color: Color(0xFF5a7335), size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _tax => _subtotal * 0.10; // 10% tax
  double get _deliveryFee {
     final option = _deliveryOptions.firstWhere(
       (opt) => opt['id'] == _selectedDelivery, 
       orElse: () => _deliveryOptions[0]
     );
     return (option['price'] as num).toDouble();
  } 
  double get _discount => 0.00;

  double get _totalPrice => _subtotal + _tax + _deliveryFee - _discount;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          LanguageService().translate('cart_title'),
          style: TextStyle(
            fontFamily: 'Hanuman', 
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      body: Column(
        children: [
          // 1. New "Friendly" Delivery Header
          _buildDeliveryHeader(),
          
          Expanded(
            child: _cartItems.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cart Items List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];
                          return _buildCartItem(item, index);
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
          ),

          // Pinned Checkout Bar with Order Summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   // Order Summary inside Bottom Sheet
                   // Collapsible Header
                  InkWell(
                    onTap: () {
                      setState(() {
                         _isSummaryExpanded = !_isSummaryExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          LanguageService().translate('order_summary'),
                          style: TextStyle(
                            fontFamily: 'Hanuman',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        Icon(
                          _isSummaryExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                          color: const Color(0xFF5a7335),
                        ),
                      ],
                    ),
                  ),
                  
                  // Collapsible Content
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: SizedBox(
                      height: _isSummaryExpanded ? null : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          _buildSummaryRow(LanguageService().translate('subtotal'), _subtotal),
                          const SizedBox(height: 8),
                          _buildSummaryRow(LanguageService().translate('tax'), _tax),
                          const SizedBox(height: 8),
                          _buildSummaryRow(LanguageService().translate('delivery_fee'), _deliveryFee),
                          const SizedBox(height: 8),
                          _buildSummaryRow(LanguageService().translate('discount'), -_discount, isDiscount: true),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LanguageService().translate('total'),
                                style: TextStyle(
                                  fontFamily: 'Hanuman',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              Text(
                                "\$${_totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5a7335),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _cartItems.isEmpty ? null : () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const KHQRDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5a7335),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LanguageService().translate('checkout'),
                            style: const TextStyle(
                              fontFamily: 'Hanuman',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }





  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    final theme = Theme.of(context);
    
      return Dismissible(
        key: Key(item['title']),
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.delete_outline, color: Colors.red),
        ),
        onDismissed: (direction) {
          setState(() {
            _cartItems.removeAt(index);
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: item['color'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(item['image'], color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['author'],
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${item['price'].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF5a7335), // Green Price
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity
              _buildQuantityControl(item, index),
            ],
          ),
        ),
      );
  }

  Widget _buildQuantityControl(Map<String, dynamic> item, int index) {
     return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          _buildQuantityBtn(Icons.remove, () {
            if (item['quantity'] > 1) {
              setState(() {
                item['quantity']--;
              });
            }
          }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            child: Text(
              "${item['quantity']}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          _buildQuantityBtn(Icons.add, () {
            setState(() {
              item['quantity']++;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 32,
          height: 36,
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "សង្ខេបការបញ្ជាទិញ (Summary)",
            style: TextStyle(
              fontFamily: 'Hanuman',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow("សរុប (Subtotal)", _subtotal),
          const SizedBox(height: 12),
          _buildSummaryRow("ពន្ធ (Tax 10%)", _tax),
          const SizedBox(height: 12),
          _buildSummaryRow("ដឹកជញ្ជូន (Delivery)", _deliveryFee),
          const SizedBox(height: 12),
          _buildSummaryRow("បញ្ចុះតម្លៃ (Discount)", -_discount, isDiscount: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ទឹកប្រាក់សរុប", // Total
                style: TextStyle(
                  fontFamily: 'Hanuman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${_totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5a7335),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isDiscount = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontFamily: 'Hanuman', fontSize: 14),
        ),
        Text(
          "${isDiscount ? '-' : ''}\$${value.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDiscount ? Colors.green : theme.textTheme.bodyLarge?.color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _cartItems.isEmpty ? null : () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const KHQRDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5a7335),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LanguageService().translate('checkout'),
                  style: const TextStyle(
                    fontFamily: 'Hanuman',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            LanguageService().translate('empty_cart'),
            style: const TextStyle(
              fontFamily: 'Hanuman',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
