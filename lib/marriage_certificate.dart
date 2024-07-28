import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MarriageCertificatePage extends StatelessWidget {
  final TextEditingController _currentTimeController = TextEditingController();
  final TextEditingController _applicationDateController = TextEditingController();
  final TextEditingController _marriageDateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _marriagePlaceAddressController = TextEditingController();
  final TextEditingController _placeOfMarriageController = TextEditingController();
  final TextEditingController _priestMobileController = TextEditingController();

  final List<String> wards = ['Ward 1', 'Ward 2', 'Ward 3']; // Example wards
  final List<String> marriageTypes = ['Type 1', 'Type 2', 'Type 3']; // Example marriage types

  String selectedWard = 'Ward 1';
  String selectedMarriageType = 'Type 1';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -screenWidth * 0.5,
            left: -screenWidth * 0.25,
            child: TopWidget(screenWidth: screenWidth),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/marriage_certificate.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Marriage Certificate',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField('Current Time', _currentTimeController),
                          buildTextField('Date of Application/विवाह पंजीकरण की तारीख', _applicationDateController),
                          buildTextField('Date Of Marriage/विवाह तिथि', _marriageDateController),
                          buildDropdown('Select Your Marriage Registration Ward/वार्ड', wards, selectedWard, (value) {
                            selectedWard = value!;
                          }),
                          buildTextField('Pincode/पिन कोड', _pincodeController),
                          buildDropdown('Type Of Marriage', marriageTypes, selectedMarriageType, (value) {
                            selectedMarriageType = value!;
                          }),
                          buildTextField('Marriage Place Address/विवाह का पता', _marriagePlaceAddressController),
                          buildTextField('Place Of Marriage/विवाह - स्थल', _placeOfMarriageController),
                          buildTextField('Priest/Imam/Church Father/Others Mobile No. / पुजारी/काजी/पादरी/पठीजी मोबाइल नंबर', _priestMobileController),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DocumentUploadPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                              child: Text('Next'),
                            ),
                          ),
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

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Type here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentUploadPage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Handle the selected image
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image selected: ${image.path}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
            SizedBox(height: 20),
            Text(
              'Upload a photo of your National ID Card',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Regulations require you to upload a national identity card. Don\'t worry, your data will stay safe and private.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => _pickImage(context, ImageSource.gallery),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        'Select file',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'or',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.camera),
              icon: Icon(Icons.camera_alt),
              label: Text('Open Camera & Take Photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[50],
                foregroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle the next step
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  final double screenWidth;

  const TopWidget({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth,
      decoration: BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.circle,
      ),
    );
  }
}

