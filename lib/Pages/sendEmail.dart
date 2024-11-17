import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class SendEmail extends StatefulWidget {
  const SendEmail({Key? key, required this.listOfObject}) : super(key: key);
  final List<dynamic>? listOfObject;

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  _sendEmail() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final subject = _subjectController.text;
    final message = _messageController.text;
/*
    // Construct the mailto URL with the email details
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '', // Enter the recipient's email address here
      queryParameters: {
        'subject': subject,
        'body': 'Name: $name\nEmail: $email\n\n$message',
      },
    );

    // Launch the default email app
    await launch(emailUri.toString());

    */
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final serviceId = 'service_yfhk2h5';
    final templateId = 'template_xntooxo';
    //'template_v47hlwb';
   // 'template_u507pqu'
    final userId = 'oEO4HfT9DA39rC8uE';
    final Map<String, dynamic> requestBody = {
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    "template_params": {
      "user_name": name,
      "user_email": email,
      "to_email":"asmasalehw@gmail.com",
      "to_name":"Asma Alwaal",
      "user_subject": subject,
      "user_message": message,
    }
  };


    final response = await http.post(
      url,
      headers:{
        'origin': 'http://localhost',
        'Content-Type': 'application/json',

      },
      body: jsonEncode(requestBody)
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 221, 255),
      appBar: AppBar(
        title: Text('Send Email'),
        backgroundColor: Color(darkBlue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              "name: Dr. ${widget.listOfObject![2]['Fname']} ${widget.listOfObject![2]['Lname']}\n${widget.listOfObject![2]['specialization']}",
              style: TextStyle(color: Color(darkerGray), fontSize: 18),
            ),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(labelText: 'Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the subject';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Message'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendEmail();
                      }
                    },
                    child: Text('Send Email'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
