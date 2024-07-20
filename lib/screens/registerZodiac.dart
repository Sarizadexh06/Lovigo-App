import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import '../providers/habit_provider.dart';

class RegisterZodiac extends StatefulWidget {
  const RegisterZodiac({Key? key}) : super(key: key);

  @override
  _RegisterZodiacState createState() => _RegisterZodiacState();
}

class _RegisterZodiacState extends State<RegisterZodiac> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: List.generate(
                      zodiacSigns.length,
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
                                  zodiacSigns[index],
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
                    style: AppStyles.textStyleTitle
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
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
              
                  SizedBox(height: 45,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterZodiac()));
                    },
                    style: AppStyles.proceedButtonStyle,
                    child: Text('Proceed',style: AppStyles.textStyleForButton,),
                  ),
                ],
              ),
            ),
          ),

      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class ZodiacCard extends StatelessWidget {
  final String zodiacSign;
  final VoidCallback onTap;

  const ZodiacCard({required this.zodiacSign, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              zodiacSign,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> zodiacSigns = [
  'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
  'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
];
