import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sukoon/Const/constant.dart';

class ContactDoctor extends StatefulWidget {
  const ContactDoctor({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;

  @override
  State<ContactDoctor> createState() => _ContactDoctorState();
}

class _ContactDoctorState extends State<ContactDoctor> {
  final _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  sendEmail(String subject, String body, String recipientemail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipientemail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(darkBlue),
        centerTitle: true,
        title: Text(
          "Send Email",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the arrow to white
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    hintText: "Enter Email", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: subject,
                decoration: const InputDecoration(
                    hintText: "Enter Subject", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: body,
                decoration: const InputDecoration(
                    hintText: "Enter Message", border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(darkBlue)), // Background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Text color
                    elevation: MaterialStateProperty.all<double>(
                        5)), // Elevation (shadow)),
                onPressed: () {
                  _key.currentState!.save();
                  sendEmail(subject.text, body.text, email.text);
                },
                child: Text("Send")),
          ],
        ),
      ),
    );
  }
}


/*

class ContactDoctor extends StatefulWidget {
  const ContactDoctor({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;
  @override
  State<ContactDoctor> createState() => _ContactDoctorState();
}

class _ContactDoctorState extends State<ContactDoctor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            sendEmail(context);
          },
          child: Text("Send Email")),
    );
  }
}

Future sendEmail(BuildContext context) async {
  final message = Message()
    ..from = Address("asmasalehw@gmail.com", " Asma Saleh")
    ..recipients = ["asma.s.w21@gmail.com"]
    ..subject = "For tring the message"
    ..text = "this is the test email";

  try {
    await send(
        message,
        SmtpServer("smtp.gmail.com",
            username: 'asmasalehw',
            password: 'Asma***666',
            port: 587,
            ssl: false,
            allowInsecure: false));
    showSnackBar(context, 'Send email Successfully');
  } on MailerException catch (e) {
    print(">>>>>>> ${e}");
  }
}
/*
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
  );
}
*/

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: TextStyle(fontSize: 20),
    ),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);

    
}
*/