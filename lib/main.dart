import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AFPA - Formations CDA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Accueil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedBottomBarIndex = 0;

  final Color _selectedColor = Colors.black87;  // Couleur des éléments sélectionnés
  final Color _unselectedColor = Colors.grey; // Couleur des éléments non sélectionnés
  final Color _sliderColor = Colors.lightGreen;  // Couleur du slider (barre d'indication)
  final Duration _animationDuration = const Duration(milliseconds: 300);

  // Les pages associées à chaque élément du Drawer
  final List<Widget> _pages = [
    const Center(child: Text('Page d\'Accueil')),
    const Center(child: Text('Formations')),
    const Center(child: Text('Liens Utiles')),
    const Center(child: Text('À propos de l\'application CDA')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomBarIndex = index;
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _selectedBottomBarIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 48,
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('John Doe'),
              accountEmail: const Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://randomuser.me/api/portraits/men/46.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.lightGreen,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              selected: _selectedBottomBarIndex == 0,
              selectedTileColor: Colors.lightGreenAccent.withOpacity(0.2),
              onTap: () => _navigateToPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Formations'),
              selected: _selectedBottomBarIndex == 1,
              selectedTileColor: Colors.lightGreenAccent.withOpacity(0.2),
              onTap: () => _navigateToPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Liens Utiles'),
              selected: _selectedBottomBarIndex == 2,
              selectedTileColor: Colors.lightGreenAccent.withOpacity(0.2),
              onTap: () => _navigateToPage(2),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              selected: _selectedBottomBarIndex == 3,
              selectedTileColor: Colors.lightGreenAccent.withOpacity(0.2),
              onTap: () => _navigateToPage(3),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              selected: _selectedBottomBarIndex == 4,
              selectedTileColor: Colors.lightGreenAccent.withOpacity(0.3),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Déconnexion"),
                      content: const Text("Voulez-vous vraiment vous déconnecter ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Non"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Oui"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedBottomBarIndex,
        children: _pages, // Affiche la page correspondant à l'index sélectionné
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Formations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.link),
                  label: 'Liens Utiles',
                ),
              ],
              currentIndex: _selectedBottomBarIndex,
              selectedItemColor: _selectedColor,  // Couleur personnalisée pour les éléments sélectionnés
              unselectedItemColor: _unselectedColor,  // Couleur pour les éléments non sélectionnés
              onTap: _onItemTapped,
            ),
          ),
          AnimatedPositioned(
            duration: _animationDuration,
            curve: Curves.easeInOut, // Animation douce
            left: MediaQuery.of(context).size.width / 3 * _selectedBottomBarIndex,
            child: Container(
              height: 4,
              width: MediaQuery.of(context).size.width / 3,
              color: _sliderColor,  // Conserve la couleur du slider en light green
            ),
          ),
        ],
      ),
    );
  }
}
