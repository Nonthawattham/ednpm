import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonationCentersPage extends StatefulWidget {
  @override
  _DonationCentersPageState createState() => _DonationCentersPageState();
}

class _DonationCentersPageState extends State<DonationCentersPage> {
  List<dynamic> donationCenters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDonationCenters();
  }

  Future<void> fetchDonationCenters() async {
    final url = 'https://iamnet.me/api/community/donation_centers.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          donationCenters = data['donation_centers'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load donation centers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ศูนย์รับบริจาค'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: donationCenters.length,
              itemBuilder: (context, index) {
                final center = donationCenters[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(center['name']),
                    subtitle: Text(center['address']),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationCenterDetail(center),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class DonationCenterDetail extends StatelessWidget {
  final dynamic center;

  DonationCenterDetail(this.center);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(center['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ที่อยู่: ${center['address']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('เบอร์โทร: ${center['contact']['phone']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('เวลาเปิดทำการ: ${center['opening_hours']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('สิ่งของที่รับบริจาค: ${center['accepted_items'].join(', ')}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('ข้อกำหนด: ${center['requirements']}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
