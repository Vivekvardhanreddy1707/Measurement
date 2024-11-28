import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildOrdersPage(context),
      _buildCalculationsPage(context),
      _buildCameraPage(context),
      _buildProfilePage(context), // Added Profile page
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _selectedIndex == 0
              ? "Orders"
              : _selectedIndex == 1
              ? "Calculations"
              : _selectedIndex == 2
              ? "Camera"
              : "Profile", // Display title based on selected index
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.blueGrey, // Background color for the nav bar
        selectedItemColor: Colors.blue, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for the unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calculations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Camera",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),

    );
  }

  Widget _buildOrdersPage(BuildContext context) {
    final List<Map<String, dynamic>> orders = List.generate(30, (index) {
      return {
        "orderId": "OD${12345 + index}",
        "packageAddress": "Address ${index + 1}, City ${index % 5 + 1}",
        "deliveryAgent": "Agent ${index % 10 + 1}",
        "timeLeft": "${index % 3 + 1} day${index % 3 == 0 ? '' : 's'}",
        "customerName": "Customer ${index + 1}",
        "customerAge": 20 + (index % 15),
      };
    });

    orders.sort((a, b) {
      final int timeA = int.parse(a["timeLeft"]!.split(" ")[0]);
      final int timeB = int.parse(b["timeLeft"]!.split(" ")[0]);
      return timeA.compareTo(timeB);
    });

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final timeLeft = order["timeLeft"]!;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            title: Container(
              color: timeLeft == "1 day" ? Colors.red[50] : null,
              child: ListTile(
                title: Text(
                  "Order ID: ${order["orderId"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: timeLeft == "1 day"
                    ? Icon(
                  Icons.warning,
                  color: Colors.red,
                )
                    : null,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer Name: ${order["customerName"]}"),
                    Text("Customer Age: ${order["customerAge"]}"),
                    Text("Package Address: ${order["packageAddress"]}"),
                    Text("Delivery Agent: ${order["deliveryAgent"]}"),
                    Text("Time Left: $timeLeft"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalculationsPage(BuildContext context) {
    final TextEditingController lengthController = TextEditingController();
    final TextEditingController breadthController = TextEditingController();
    final TextEditingController heightController = TextEditingController();

    String result = '';

    void calculate(Function() operation) {
      try {
        result = operation().toStringAsFixed(2);
        showToast(message: "Result: $result");
      } catch (e) {
        showToast(message: "Enter valid input(s)");
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Dimensions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Length",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: breadthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Breadth (Optional for Square/Cube)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Height (Optional for Square/Rectangle)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => calculate(() {
                    final side = double.parse(lengthController.text);
                    return side * side; // Area of Square
                  }),
                  child: const Text("Area of Square"),
                ),
                ElevatedButton(
                  onPressed: () => calculate(() {
                    final length = double.parse(lengthController.text);
                    final breadth = double.parse(breadthController.text);
                    return length * breadth; // Area of Rectangle
                  }),
                  child: const Text("Area of Rectangle"),
                ),
                ElevatedButton(
                  onPressed: () => calculate(() {
                    final side = double.parse(lengthController.text);
                    return side * side * side; // Volume of Cube
                  }),
                  child: const Text("Volume of Cube"),
                ),
                ElevatedButton(
                  onPressed: () => calculate(() {
                    final length = double.parse(lengthController.text);
                    final breadth = double.parse(breadthController.text);
                    final height = double.parse(heightController.text);
                    return length * breadth * height; // Volume of Cuboid
                  }),
                  child: const Text("Volume of Cuboid"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Camera functionality not implemented",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast(message: "Successfully signed out");
            },
            child: Container(
              height: 45,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
