import 'package:flutter/material.dart';
import '../l10n/language_service.dart';
import 'map_picker_page.dart';

class AddressEditPage extends StatefulWidget {
  final String? initialAddress;
  final String? initialPhone;

  const AddressEditPage({super.key, this.initialAddress, this.initialPhone});

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
  }

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
}