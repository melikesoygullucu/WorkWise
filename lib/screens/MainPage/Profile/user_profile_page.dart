import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> job;

  const UserProfilePage({required this.user, required this.job});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isApproved = false;
  List<Map<String, dynamic>> abilities = [];

  Future<MySqlConnection> getConnection() async {
    final settings = new ConnectionSettings(
      host: '213.238.183.81',
      port: 3306,
      user: 'httpdegm_hudai',
      password: ',sPE[gd^hbl1',
      db: 'httpdegm_database1',
    );
    return await MySqlConnection.connect(settings);
  }

  Future<List<Map<String, dynamic>>> fetchAbilities(int userId) async {
    final conn = await getConnection();

    final results =
    await conn.query('SELECT abilities, rating FROM profile WHERE user_id = ?', [userId]);

    final List<Map<String, dynamic>> fetchedAbilities = [];
    for (var row in results) {
      final fields = row.fields;
      final ability = fields['abilities'] as String;
      final rating = fields['rating']?.toInt() ?? 0;
      fetchedAbilities.add({'abilities': ability, 'rating': rating});
    }

    await conn.close();

    return fetchedAbilities;
  }

  Future<void> fetchApplicationStatus() async {
    final conn = await getConnection();

    try {
      final results = await conn.query(
        'SELECT is_approved FROM job_applications WHERE job_id = ? AND freelancer_id = ?',
        [widget.job['id'], widget.user['id']],
      );

      if (results.isNotEmpty) {
        final application = results.first.fields;
        setState(() {
          isApproved = application['is_approved'] == 1;
        });
      }
    } catch (e) {
      print('An error occurred while fetching application status: $e');
    } finally {
      await conn.close();
    }
  }

  Future<void> approveApplication() async {
    final conn = await getConnection();

    try {
      await conn.query(
        'UPDATE job_applications SET is_approved = 1 WHERE job_id = ? AND freelancer_id = ?',
        [widget.job['id'], widget.user['id']],
      );
      print('Application approved successfully!');
      setState(() {
        isApproved = true;
      });
      sendNotification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job approved successfully'),
        ),
      );
    } catch (e) {
      print('An error occurred while approving the application: $e');
    } finally {
      await conn.close();
    }
  }

  Future<void> sendNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    var conn = await getConnection();
    String jobTitle = widget.job['job_title'];
    String message =
        'Your application for the job $jobTitle has been approved. Our team will contact you soon.';
    await conn.query(
      'INSERT INTO notifications (sender_id, job_id, is_read, receiver_id, message) VALUES (?, ?, ?, ?, ?)',
      [userId, widget.job['id'], 0, widget.user['id'], message],
    );
    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    fetchApplicationStatus();
    fetchAbilities(widget.user['id']).then((List<Map<String, dynamic>> fetchedAbilities) {
      setState(() {
        abilities = fetchedAbilities;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.user['nameandsurname']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Age: ${widget.user['age']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Abilities',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: abilities.length,
                itemBuilder: (context, index) {
                  final ability = abilities[index];
                  final String abilityName = ability['abilities'];
                  final int rating = ability['rating'];

                  return Card(
                    child: ListTile(
                      title: Text(abilityName),
                      subtitle: Text('Rating: $rating'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mail),
                      title: Text('Email'),
                      subtitle: Text('${widget.user['email']}'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isApproved ? null : approveApplication,
              child: Text(isApproved ? 'Application Approved' : 'Approve Application'),
            ),
          ],
        ),
      ),
    );
  }
}
