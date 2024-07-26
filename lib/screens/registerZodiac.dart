import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:lovigoapp/providers/habit_provider.dart';
import '../styles.dart';
import 'package:lovigoapp/modules/zodiac_module.dart';
import 'package:lovigoapp/modules/userInfo.dart';
import 'package:lovigoapp/screens/registerExtraInfo.dart';

class RegisterZodiac extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterZodiac({Key? key, required this.userInfo}) : super(key: key);

  @override
  _RegisterZodiacState createState() => _RegisterZodiacState();
}

class _RegisterZodiacState extends State<RegisterZodiac> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  List<Datum> _zodiacSigns = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchZodiacSigns();
    _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  Future<void> _fetchZodiacSigns() async {
    final response = await http.get(Uri.parse('http://lovigo.net/zodiacs'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      setState(() {
        _zodiacSigns = jsonResponse.map((zodiac) => Datum.fromJson(zodiac)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load zodiac signs');
    }
  }

  void _onProceed() {
    final provider = Provider.of<HabitProvider>(context, listen: false);

    if (provider.selectedZodiacIndex != null && provider.selectedZodiacIndex! < _zodiacSigns.length) {
      final selectedZodiacId = _zodiacSigns[provider.selectedZodiacIndex!].id;

      if (selectedZodiacId != null) {
        // Debug log to check values
        log('Selected Zodiac ID: $selectedZodiacId');

        widget.userInfo.zodiacId = selectedZodiacId;

        // Log UserInfo after setting Zodiac ID
        log('User Info after setting Zodiac ID: ${widget.userInfo.zodiacId}');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterExtraInfo(userInfo: widget.userInfo),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Zodiac ID')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a valid zodiac sign')),
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Zodiac Sign',
                        style: AppStyles.textStyleTitle,
                      ),
                    ),
                    SizedBox(height: 50),
                    Divider(),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: List.generate(
                        _zodiacSigns.length,
                            (index) => InkWell(
                          onTap: () {
                            Provider.of<HabitProvider>(context, listen: false).selectZodiacIndex(index);
                          },
                          child: Consumer<HabitProvider>(
                            builder: (context, provider, child) {
                              bool isSelected = provider.selectedZodiacIndex == index;
                              return Card(
                                elevation: 4,
                                shadowColor: Colors.cyanAccent,
                                color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(13),
                                  child: Text(
                                    _zodiacSigns[index].name ?? '',
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 50),
                    Text(
                      'Date of Birth',
                      style: AppStyles.textStyleTitle,
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                    //    _selectDate(context);
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date of birth',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            hintText: DateFormat('yyyy-MM-dd').format(selectedDate),
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
                    ElevatedButton(
                      onPressed: _onProceed,
                      style: AppStyles.proceedButtonStyle,
                      child: Text('Proceed', style: AppStyles.textStyleForButton),
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.0),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 /* Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  */
}
