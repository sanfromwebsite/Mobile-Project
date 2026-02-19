import 'package:flutter/material.dart';
import '../l10n/language_service.dart';
import 'map_picker_page.dart';

class AddressEditPage extends StatefulWidget {
  final String? initialAddress;
  final String? initialPhone;
  final String? initialDeliveryMethod;

  const AddressEditPage({super.key, this.initialAddress, this.initialPhone, this.initialDeliveryMethod});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Sok San");
    _phoneController = TextEditingController(text: widget.initialPhone ?? "012 345 678");
    _addressController = TextEditingController(text: widget.initialAddress ?? "ផ្ទះលេខ ១២៣, ផ្លូវកម្ពុជាក្រោម");
    _cityController = TextEditingController(text: "ភ្នំពេញ");
    _selectedDelivery = widget.initialDeliveryMethod ?? "J&T";
  }

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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Light Gray Bg
      appBar: AppBar(
        title: Text(
          LanguageService().translate('edit_address'),
          style: const TextStyle(
            fontFamily: 'Hanuman',
            fontWeight: FontWeight.bold,
            color: Color(0xFF5a7335),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF5a7335)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(LanguageService().translate('delivery_method')),
              _buildDeliverySelector(),
              const SizedBox(height: 25),

              _buildSectionTitle(LanguageService().translate('contact_info')),
              _buildTextField(LanguageService().translate('name_label'), _nameController, Icons.person_outline),
              const SizedBox(height: 15),
              _buildTextField(LanguageService().translate('phone_label'), _phoneController, Icons.phone_outlined, keyboardType: TextInputType.phone),
              
              const SizedBox(height: 25),
              _buildSectionTitle(LanguageService().translate('delivery_location')),
              _buildTextField(LanguageService().translate('address_label'), _addressController, Icons.location_on_outlined),
              const SizedBox(height: 15),
              _buildTextField(LanguageService().translate('city_label'), _cityController, Icons.location_city_outlined),
              
              const SizedBox(height: 20),
              
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPickerPage()),
                  );
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      _addressController.text = result['address'];
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5a7335).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF5a7335).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.map_outlined, color: Color(0xFF5a7335)),
                      const SizedBox(width: 12),
                      Text(
                        LanguageService().translate('choose_on_map'),
                        style: const TextStyle(
                          fontFamily: 'Hanuman',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5a7335),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded, color: Color(0xFF5a7335)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Return new data
                      Navigator.pop(context, {
                        'address': _addressController.text,
                        'phone': _phoneController.text,
                        'deliveryMethod': _selectedDelivery,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5a7335),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    LanguageService().translate('save_btn'),
                    style: const TextStyle(
                      fontFamily: 'Hanuman',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Hanuman',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5a7335),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {TextInputType? keyboardType}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontFamily: 'Hanuman', fontSize: 16, color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Hanuman'),
          prefixIcon: Icon(icon, color: const Color(0xFF5a7335)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'សូមបំពេញព័ត៌មាននេះ'; // Please fill this info
          }
          return null;
        },
      ),
    );
  }
  Widget _buildDeliverySelector() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _deliveryOptions.map((option) {
          final isSelected = _selectedDelivery == option['id'];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDelivery = option['id'];
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 15),
              width: 140, // Slightly wider for images
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? (isDark ? const Color(0xFF5a7335).withOpacity(0.3) : const Color(0xFF5a7335).withOpacity(0.1))
                    : theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF5a7335) : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: option['image'] != null 
                        ? DecorationImage(
                            image: AssetImage(option['image']),
                            fit: BoxFit.contain, // Adjust fit as needed
                          )
                        : null,
                    ),
                    child: option['image'] == null 
                      ? Icon(option['icon'], color: option['color'], size: 24)
                      : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    option['name'],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Hanuman',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isSelected ? const Color(0xFF5a7335) : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option['duration'],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${option['price'].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF5a7335),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}