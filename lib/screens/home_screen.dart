import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';
import 'package:dekora/models/flower_model.dart';
import 'package:dekora/services/flower_service.dart';
import 'package:dekora/widgets/custom_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'flower_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flower> flowers = [];
  List<Flower> filteredFlowers = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  int _selectedIndex = 0;
  User? user;

  @override
  void initState() {
    super.initState();
    fetchFlowers();
    searchController.addListener(() {
      filterFlowers();
    });
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> fetchFlowers() async {
    try {
      List<Flower> fetchedFlowers = await FlowerService.fetchFlowers();
      setState(() {
        flowers = fetchedFlowers;
        filteredFlowers = fetchedFlowers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load flowers: $e');
    }
  }

  void filterFlowers() {
    List<Flower> _flowers = [];
    _flowers.addAll(flowers);
    if (searchController.text.isNotEmpty) {
      _flowers.retainWhere((flower) {
        String searchTerm = searchController.text.toLowerCase();
        String flowerName = flower.name.toLowerCase();
        return flowerName.contains(searchTerm);
      });
    }
    setState(() {
      filteredFlowers = _flowers;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFlowerTap(Flower flower) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlowerDetailScreen(flower: flower),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dekora',
          style: TextStyle(
            fontFamily: 'Laviossa',
            fontSize: 28,
            color: GlobalVariables.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: GlobalVariables.primaryColor),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: GlobalVariables.primaryColor),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon:
                        Icon(Icons.search, color: GlobalVariables.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Hello, ${user?.displayName ?? 'User'}!',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: GlobalVariables.primaryColor,
                  ),
                ),
                const Text(
                  'Happy Renting :)',
                  style: TextStyle(
                      fontSize: 20, color: GlobalVariables.primaryColor),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: filteredFlowers.length,
                          itemBuilder: (context, index) {
                            final flower = filteredFlowers[index];
                            return GestureDetector(
                              onTap: () => _onFlowerTap(flower),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GlobalVariables.primaryColor,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    flower.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}
