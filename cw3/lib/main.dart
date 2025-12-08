import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MyApp', home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String num1 = "";
  String num2 = "";
  String operator = "";
  String showVal = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator STF"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showVal,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),

            // Row 7 8 9 +
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "7";
                        } else {
                          num1 += "7";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "7";
                        } else {
                          num2 += "7";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("7"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "8";
                        } else {
                          num1 += "8";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "8";
                        } else {
                          num2 += "8";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("8"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "9";
                        } else {
                          num1 += "9";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "9";
                        } else {
                          num2 += "9";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("9"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        operator = "+";
                      } else {}
                    });
                  },
                  child: Text("+"),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Row 4 5 6 -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "4";
                        } else {
                          num1 += "4";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "4";
                        } else {
                          num2 += "4";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("4"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "5";
                        } else {
                          num1 += "5";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "5";
                        } else {
                          num2 += "5";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("5"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "6";
                        } else {
                          num1 += "6";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "6";
                        } else {
                          num2 += "6";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("6"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        operator = "-";
                      } else {}
                    });
                  },
                  child: Text("-"),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Row 1 2 3 *
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "1";
                        } else {
                          num1 += "1";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "1";
                        } else {
                          num2 += "1";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("1"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "2";
                        } else {
                          num1 += "2";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "2";
                        } else {
                          num2 += "2";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("2"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "3";
                        } else {
                          num1 += "3";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "3";
                        } else {
                          num2 += "3";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("3"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        operator = "*";
                      } else {}
                    });
                  },
                  child: Text("*"),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Row 0 C = /
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        if (num1 == "") {
                          num1 = "0";
                        } else {
                          num1 += "0";
                        }
                        showVal = num1;
                      } else {
                        if (num2 == "") {
                          num2 = "0";
                        } else {
                          num2 += "0";
                        }
                        showVal = num2;
                      }
                    });
                  },
                  child: Text("0"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (true) {
                        num1 = "";
                        num2 = "";
                        operator = "";
                        showVal = "0";
                      } else {}
                    });
                  },
                  child: Text("C"),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (num1 != "" && num2 != "" && operator != "") {
                        double n1 = double.parse(num1);
                        double n2 = double.parse(num2);
                        double result = 0;
                        if (operator == "+") {
                          result = n1 + n2;
                        } else if (operator == "-") {
                          result = n1 - n2;
                        } else if (operator == "*") {
                          result = n1 * n2;
                        } else if (operator == "/") {
                          result = n1 / n2;
                        } else {}
                        showVal = result.toString();
                        num1 = result.toString();
                        num2 = "";
                        operator = "";
                      } else {}
                    });
                  },
                  child: Text("="),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (operator == "") {
                        operator = "/";
                      } else {}
                    });
                  },
                  child: Text("/"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
