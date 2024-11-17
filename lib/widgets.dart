import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/deviceInstr.dart';
import "package:http/http.dart" as http;
import 'dart:convert' as convert;

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    this.hint,
    this.icon,
    required this.controllerName,
    required this.validatorName,
  });

  final String? hint;
  final IconData? icon;
  final TextEditingController? controllerName;
  final String? Function(String?)? validatorName;

  Widget build(BuildContext context) {
    bool obscureText = (hint == "Confirm password" || hint == "Enter password");
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: SizedBox(
        width: 287,
        height: 45,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Color(darkerGray), size: 32),
            filled: true,
            fillColor: Color(lightGray),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(darkerGray),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(darkGray),
                style: BorderStyle.solid,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
            ),
          ),
          controller: controllerName,
          validator: validatorName,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
        ),
      ),
    );
  }
}

// ---------------------------------------- Input form for the dropDown

class InputFormDropdownSelector extends StatefulWidget {
  const InputFormDropdownSelector({
    Key? key,
    required this.controllerName,
    required this.validatorName,
    required this.dropdownItems,
  }) : super(key: key);

  final TextEditingController? controllerName;
  //final String? Function(String?)? validatorName;
  final List<String>? dropdownItems;
  final String? validatorName;

  @override
  State<InputFormDropdownSelector> createState() =>
      _InputFormDropdownSelectorState();
}

class _InputFormDropdownSelectorState extends State<InputFormDropdownSelector> {
  @override
  Widget build(BuildContext context) {
    print(widget.dropdownItems?[0]);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: SizedBox(
        width: 287,
        height: 45,
        child: DropdownButtonFormField<String>(
          value: widget.validatorName,
          onChanged: (String? newValue) {
            setState(() {
              //widget.validatorName = newValue; // ERROR
              widget.controllerName?.text = newValue ?? '';
            });
          },
          items: widget.dropdownItems?.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(lightGray),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(darkGray),
                style: BorderStyle.solid,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
            ),
          ),
          /*validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select an option";
                }
                return null;
              },*/
        ),
      ),
    );
  }
}

//------------------------------ Wide Blue Button >>

class wideBlueBotton extends StatelessWidget {
  const wideBlueBotton({super.key, required this.label, required this.page});

  @override
  final String label;
  final Widget page;
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(287, 45),
            alignment: Alignment.center,
            backgroundColor: Color(darkBlue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ));
  }
}

//----------------------------- subscribe question >>>S
class subscriberQues extends StatelessWidget {
  const subscriberQues(
      {super.key,
      required this.quesion,
      required this.buttonPage,
      required this.page,
      this.wiendow});

  final String quesion;
  final String buttonPage;
  final Widget page;
  final Widget? wiendow;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          quesion,
          style: const TextStyle(
              color: Color(darkerGray2),
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Text(
            buttonPage,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(darkBlue),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

//------------------------- Upper Bar Title
class UpperBarTitle extends StatelessWidget {
  const UpperBarTitle({super.key, required this.title, required this.space});

  @override
  final String title;
  final double space;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(gray),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(darkBlue),
              size: 32,
            ),
          ),
        ),
        SizedBox(
          width: space,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(darkBlue),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

//------------------------------ Wide Gray Button >>

class wideGrayBotton extends StatelessWidget {
  const wideGrayBotton(
      {super.key, required this.label, this.page, this.weindow});

  @override
  final String label;
  final dynamic page;
  final Function()? weindow;
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            fixedSize: Size(315, 63),
            alignment: Alignment.center,
            backgroundColor: Color(darkGray),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          if (page is DeviceInstr) {
            print(">>>>>>>{$page}");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          } else {
            weindow!(); // call functions
          }
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Color(darkBlue),
          ),
        ));
  }
}
//------------------------------ Wide Gray Button >>

class dialogGrayBotton extends StatelessWidget {
  const dialogGrayBotton({super.key, required this.label, this.weindow});

  @override
  final String label;
  final void Function()? weindow;
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            fixedSize: Size(315, 63),
            alignment: Alignment.center,
            backgroundColor: Color(darkGray),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: weindow,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Color(darkBlue),
          ),
        ));
  }
}

//------------------------------ Dialog Connection >>

class AdvancedCustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        //overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 260,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  const Text(
                    "Device is Not Conected",
                    style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: Color(darkBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Reload',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*
          const Positioned(
            
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 60,
              child: Icon(
                
                Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                size: 80,
                color: Colors.white,
              ),
            ),
            top: -60,
          ),
          */
        ],
      ),
    );
  }
}

//------------------------------ Upper Blue Bar

//--------------------------------------------------  History Card
class historyCard extends StatelessWidget {
  const historyCard(
      {super.key,
      required this.Eresult,
      required this.time,
      required this.date});

  final String Eresult;
  final String time;
  final String date;
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 120,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Color(lightGray),
          border: Border.all(color: Color(darkerGray), width: 2),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color(darkerGray),
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(-1, 2),
            )
          ]),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.list_alt_outlined,
                color: Color(darkBlue),
                size: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                Eresult,
                style: const TextStyle(
                  color: Color(darkerGray2),
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.timer_outlined,
                color: Color(darkBlue),
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Color(darkerGray2),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.calendar_today_outlined,
                color: Color(darkBlue),
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Color(darkerGray2),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//==================================================================== Functions ===================================================

bool validateEmail(String? email) {
  RegExp emailRegx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailvalid = emailRegx.hasMatch(email ?? '');
  return isEmailvalid;
}

Future<bool> checkIfIdIsUniqueC(int id) async {
  // Execute the SQL query to fetch all caregiver IDs
  String url =
      "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver";

  http.Response response = await http.get(Uri.parse(url));
  List<dynamic> data = convert.json.decode(response.body);

  for (var item in data) {
    if (item['caregiverID'] == id) {
      return false;
    }
  }

  return true; // ID is unique
}

Future<bool> checkIfIdIsUniqueP(int id) async {
  // Execute the SQL query to fetch all caregiver IDs
  String url =
      "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listPatient";

  http.Response response = await http.get(Uri.parse(url));
  List<dynamic> data = convert.json.decode(response.body);

  for (var item in data) {
    if (item['PatientID'] == id) {
      return false;
    }
  }

  return true; // ID is unique
}

Future<bool> checkEmailExisting(String? email) async {
  String url =
      "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver";
  http.Response response = await http.get(Uri.parse(url));
  List<dynamic> data = convert.json.decode(response.body);

  bool isExit = false;
  for (var item in data) {
    if (item['Email'].toString() == email) {
      isExit = true;
      break;
    }
  }

  return isExit;
}

Future<List> getData() async {
  String url =
      "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver";
  http.Response response = await http.get(Uri.parse(url));
  return convert.json.decode(response.body);
}
