import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'roundediconbutton.dart';
import 'bottom_button.dart';
import 'calculator_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 74;
  int age = 18;

  Widget lastCard(String varType, int numType) {
    return Row(
      children: [
        Expanded(
          child: ReusableCard(
            colour: kActivecolour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  varType,
                  style: kLableStyle,
                ),
                Text(
                  weight.toString(),
                  style: kTextStyle,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RoundIconButton(
                    icon: FontAwesomeIcons.minus,
                    onClick: () {
                      setState(() {
                        weight--;
                      });
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.plus,
                    onClick: () {
                      setState(() {
                        weight++;
                      });
                    },
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = Gender.male;
                  });
                },
                colour: selectedGender == Gender.male
                    ? kActivecolour
                    : kInActivecolour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.mars,
                  cardText: 'MALE',
                ),
              )),
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = Gender.female;
                  });
                },
                colour: selectedGender == Gender.female
                    ? kActivecolour
                    : kInActivecolour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  cardText: 'FEMALE',
                ),
              )),
            ],
          )),

          //here we add the slider card
          Expanded(
            child: ReusableCard(
              colour: kActivecolour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: kLableStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: kTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLableStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 25.0)),
                    child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newVal) {
                          setState(() {
                            height = newVal.toInt();
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ReusableCard(
                colour: kActivecolour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weight',
                      style: kLableStyle,
                    ),
                    Text(
                      weight.toString(),
                      style: kTextStyle,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onClick: () {
                          setState(() {
                            weight--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onClick: () {
                          setState(() {
                            weight++;
                          });
                        },
                      )
                    ])
                  ],
                ),
              )),
              Expanded(
                  child: ReusableCard(
                colour: kActivecolour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Age',
                      style: kLableStyle,
                    ),
                    Text(
                      age.toString(),
                      style: kTextStyle,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onClick: () {
                          setState(() {
                            age--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onClick: () {
                          setState(() {
                            age++;
                          });
                        },
                      )
                    ])
                  ],
                ),
              )),
            ],
          )),
          BottomButton(
            bottomText: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            bmiResult: calc.calculateBMI(),
                            interpretationResult: calc.getInterpretation(),
                            resultText: calc.getResult(),
                          )));
            },
          ),
        ],
      ),
    );
  }
}
