import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lovigoapp/screens/registerLifeStyle.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/relationship_type.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/services/api_service.dart';

class RegisterInterests extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterInterests({super.key, required this.userInfo});

  @override
  State<RegisterInterests> createState() => _RegisterInterestsState();
}

class _RegisterInterestsState extends State<RegisterInterests> {
  List<RelationshipType> _relationshipTypes = [];
  int? _selectedRelationshipTypeId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRelationshipTypes();
  }

  Future<void> _fetchRelationshipTypes() async {
    final response = await http.get(Uri.parse('https://lovigo.net/relationship-types'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        _relationshipTypes = jsonResponse.map((type) => RelationshipType.fromJson(type)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load relationship types');
    }
  }

  void _onCardClick(int relationshipTypeId) {
    setState(() {
      if (_selectedRelationshipTypeId == relationshipTypeId) {
        _selectedRelationshipTypeId = null;
      } else {
        _selectedRelationshipTypeId = relationshipTypeId;
      }
    });
  }

  void _onProceed() {
    if (_selectedRelationshipTypeId != null) {
      widget.userInfo.relationshipTypeId = _selectedRelationshipTypeId!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterLifeStyle(userInfo: widget.userInfo), // RegisterLifeStyle sayfasına yönlendirme
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a relationship type')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: gradientDecoration,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60, left: 30),
                      child: Text(
                        'Select your own wish!',
                        style: AppStyles.textStyleTitle,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _relationshipTypes.length,
                        itemBuilder: (context, index) {
                          return InterestCard(
                            label: _relationshipTypes[index].name,
                            isSelected: _selectedRelationshipTypeId == _relationshipTypes[index].id,
                            isClickable: _selectedRelationshipTypeId == null || _selectedRelationshipTypeId == _relationshipTypes[index].id,
                            onCardClick: () => _onCardClick(_relationshipTypes[index].id),
                          );
                        },
                      ),
                    ),
                    if (_selectedRelationshipTypeId != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _onProceed,
                            child: Text(
                              'Proceed',
                              style: AppStyles.textStyleForButton,
                            ),
                            style: AppStyles.proceedButtonStyle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InterestCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isClickable;
  final VoidCallback onCardClick;

  InterestCard({
    required this.label,
    required this.isSelected,
    required this.isClickable,
    required this.onCardClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClickable ? onCardClick : null,
      child: Card(
        color: isSelected
            ? Color.fromARGB(255, 231, 103, 236)
            : Color.fromARGB(255, 255, 240, 245),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Görüntüyü kaldırdık çünkü API'den yalnızca metin geliyor
              // Görüntüleri geri eklemek isterseniz, label isimlerine göre uygun bir resim ekleyebilirsiniz.
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 189, 35, 186).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
