import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details App',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pinkAccent),
        scaffoldBackgroundColor: Colors.grey[200],
       textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.black87,
      fontSize: 16.0,
    ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 202, 207, 103)
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/userDetails': (context) => UserDetailsPage(),
      },
    );
  }
}


class HomePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App for User Details',
          style: TextStyle(color: Color.fromARGB(255, 252, 252, 252),
          fontStyle: FontStyle.italic),
          
        ),
        backgroundColor: const Color.fromARGB(255, 159, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person, color: Color.fromARGB(255, 241, 5, 5)),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email, color: Color.fromARGB(255, 241, 5, 5)),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: rollNoController,
                  decoration: const InputDecoration(
                    labelText: 'Roll No',
                    icon: Icon(Icons.format_list_numbered, color:Color.fromARGB(255, 241, 5, 5)),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    icon: Icon(Icons.phone, color: Color.fromARGB(255, 241, 5, 5)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the UserDetailsPage
                    Navigator.pushNamed(
                      context,
                      '/userDetails',
                      arguments: UserDetailsArguments(
                        name: nameController.text,
                        email: emailController.text,
                        rollNo: rollNoController.text,
                        phoneNumber: phoneNumberController.text,
                      ),
                      ).then((_) {
                      // Reset text controllers after pressing the Logout button
                      nameController.text = '';
                      emailController.text = '';
                      rollNoController.text = '';
                      phoneNumberController.text = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 222, 140, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Show Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class UserDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserDetailsArguments? args =
        ModalRoute.of(context)?.settings.arguments as UserDetailsArguments?;

    if (args == null) {
      // Handle the case where args is null
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Color.fromARGB(255, 202, 22, 22),
        ),
        body: const Center(
          child: Text('Error: Details of the user not provided.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details of the User',
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color.fromARGB(255, 202, 22, 22),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserInfoCard(
              label: 'Name',
              value: args.name,
              icon: Icons.person,
            ),
            UserInfoCard(
              label: 'Email',
              value: args.email,
              icon: Icons.email,
            ),
            UserInfoCard(
              label: 'Roll No',
              value: args.rollNo,
              icon: Icons.format_list_numbered,
            ),
            UserInfoCard(
              label: 'Phone Number',
              value: args.phoneNumber,
              icon: Icons.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show logout popup
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Logout'),
                    content: Text('User "${args.name}" Logged out.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the popup
                          Navigator.pop(context); // Go back to the previous page
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 222, 140, 8),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  UserInfoCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}


class UserDetailsArguments {
  final String name;
  final String email;
  final String rollNo;
  final String phoneNumber;

  UserDetailsArguments({
    required this.name,
    required this.email,
    required this.rollNo,
    required this.phoneNumber,
  });
}
