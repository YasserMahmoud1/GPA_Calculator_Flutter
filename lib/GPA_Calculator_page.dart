import 'package:flutter/material.dart';

double calculateGPA(double grade, int creditHours)
{
  if(grade >= 90)
  {
    return 4.0 * creditHours;
  }
  else if (grade >= 85 && grade < 90)
  {
    return 3.6 * creditHours;
  }
  else if (grade >= 80 && grade < 85)
  {
    return 3.3 * creditHours;
  }
  else if (grade >= 75 && grade < 80)
  {
    return 3.0 * creditHours;
  }
  else if (grade >= 70 && grade < 75)
  {
    return 2.6 * creditHours;
  }
  else if (grade >= 65 && grade < 70)
  {
    return 2.4 * creditHours;
  }
  else if (grade >= 60 && grade < 65)
  {
    return 2.2 * creditHours;
  }
  else if (grade >= 50 && grade < 60)
  {
    return 2.0 * creditHours;
  }
  else
  {
    return 0.0;
  }
}


class subjects
{
  double grade = 50.0;
  final int creditHours;
  final String name;

  subjects({
    required this.creditHours,
    required this.name,
  });
}

double GPA(List<subjects> s)
{
  double result = 0;
  for (subjects element in s) {
    result += calculateGPA(element.grade, element.creditHours);
  }
  result = result / 36.0 ;
  return result;
}

class GPACalculator extends StatefulWidget {

  @override
  State<GPACalculator> createState() => _GPACalculatorState();
}

class _GPACalculatorState extends State<GPACalculator> {

  List<subjects> subs =[
    subjects(creditHours: 3, name: 'Discrete Structure'),
    subjects(creditHours: 3, name: 'OOP'),
    subjects(creditHours: 3, name: 'IS'),
    subjects(creditHours: 3, name: 'Math 3'),
    subjects(creditHours: 2, name: 'Professional Ethics'),
    subjects(creditHours: 3, name: 'DSP'),
    subjects(creditHours: 1, name: 'Modern Management'),
    subjects(creditHours: 3, name: 'Data Structure'),
    subjects(creditHours: 2, name: 'Project Management'),
    subjects(creditHours: 3, name: 'SAD'),
    subjects(creditHours: 3, name: 'File Organisation'),
    subjects(creditHours: 3, name: 'Probability'),
    subjects(creditHours: 2, name: 'OR'),
    subjects(creditHours: 1, name: 'Future Science'),
    subjects(creditHours: 1, name: 'Entrepreneurship'),

  ];

  double result = 0;
  double oldGPA = 2.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GPA CALCULATOR',
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 70,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Old GPA',
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          oldGPA.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w900),
                        ),

                        Slider(
                          value: oldGPA,
                          onChanged: (value) {
                            setState((){
                              oldGPA = double.parse(value.toStringAsFixed(2));
                            });
                          },
                          max: 4.0,
                          min: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                    itemBuilder: (context,index) =>buildChatItem(subs[index]),
                    separatorBuilder: (context,index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: subs.length,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        color: Colors.blue,
        child: MaterialButton(
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ) ,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'This Year GPA : ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          GPA(subs) .toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Cumulative GPA : ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          ((GPA(subs) + oldGPA) / 2.0).toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Text(
            'Calculate',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );

  }

  Widget buildChatItem(subjects subject) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[300],
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subject.name,
            style:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),

          Text(
            '${subject.grade.round()}',
            style: const TextStyle(
                fontSize: 50, fontWeight: FontWeight.w900),
          ),

          Slider(
            value: subject.grade,
            onChanged: (value) {
              setState((){
                subject.grade = value.round().toDouble();
              });
            },
            max: 100,
            min: 0,
          ),
        ],
      ),
    ),
  );
}
