import 'package:flutter/material.dart';
import 'sentiment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  final List<Widget> _screens = [
    const Center(
        child: Text('Dashboard Screen')), // Replace with actual screen widgets
    const Center(child: Text('Risk Analysis Screen')),
    const Center(child: Text('Trade Analysis Screen')),
    const Center(child: Text('Learn Trade Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex Trend Sense'),
        backgroundColor: const Color(0xFF3C096C),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3C096C),
              ),
              child: Text('Menu', style: TextStyle(fontSize: 24)),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: const Text('Sentiment Analysis'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewProfileScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()),
                );
              },
              // Add more options as needed
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Profile'),
        backgroundColor: const Color(0xFF3C096C),
      ),
      body: const Center(
        child: Text('This is the View Profile Screen'),
      ),
    );
  }
}

// Placeholder screen for Settings
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF3C096C),
      ),
      body: const Center(
        child: Text('This is the Settings Screen'),
      ),
    );
  }
}

// Placeholder screen for About Us
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF3C096C),
      ),
      body: const Center(
        child: Text('This is the About Us Screen'),
      ),
    );
  }
}

class TopNavigation extends StatelessWidget {
  const TopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('WatchList', true, () {
            // Add navigation logic
          }),
          _buildNavItem('Home', false, () {
            // Add navigation logic
          }),
          _buildNavItem('Risk Score', false, () {
            // Add navigation logic
          }),
          _buildNavItem('Sentiment Analysis', false, () {
            // Add navigation logic
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SentimentAnalysisScreen(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3C096C) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF27292C),
            fontFamily: 'Alata',
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class SentimentAnalysisScreen extends StatelessWidget {
  const SentimentAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentiment Analysis'),
        backgroundColor: const Color.fromARGB(255, 32, 9, 108),
      ),
      body: Center(
        child: const Text('This is the Sentiment Analysis Screen'),
      ),
    );
  }
}

class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Watch List',
            style: TextStyle(
              fontFamily: 'Alata',
              fontSize: 16,
              color: Color(0xFF27292C),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCurrencyItem('USD'),
              _buildCurrencyItem('EUR'),
              _buildCurrencyItem('USDJPY'),
              _buildCurrencyItem('AUDUSD'),
              _buildAddButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyItem(String currency) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33),
            color: const Color(0xFFEEEEEE),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currency,
          style: const TextStyle(
            fontFamily: 'Alata',
            fontSize: 12,
            color: Color(0xFF27292C),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF27292C)),
          ),
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        const Text(
          'Add',
          style: TextStyle(
            fontFamily: 'Alata',
            fontSize: 12,
            color: Color(0xFF27292C),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigation(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF191826),
      selectedItemColor: const Color(0xFFF2F2F2),
      unselectedItemColor: const Color(0xFF787878),
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Risk Analysis',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Trade Analysis',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Learn Trade',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

Widget _buildNavItem(
    String label, bool isActive, int index, VoidCallback onTap) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.circle,
        size: 20,
        color: isActive ? const Color(0xFFF2F2F2) : const Color(0xFF787878),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFFF2F2F2) : const Color(0xFF787878),
          fontSize: 12,
        ),
      ),
    ],
  );
}
