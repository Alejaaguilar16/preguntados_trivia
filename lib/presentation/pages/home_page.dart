import 'package:preguntados_trivia/presentation/pages/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> categorias = [
    {'titulo': 'Cultura Colombiana', 'imagen': 'assets/images/cultura.png'},
    {'titulo': 'Arte y Tradición', 'imagen': 'assets/images/arte.png'},
    {'titulo': 'Historia Nacional', 'imagen': 'assets/images/historia.png'},
    {'titulo': 'Fauna y Flora', 'imagen': 'assets/images/fauna.png'},
    {'titulo': 'Música Típica', 'imagen': 'assets/images/musica.png'},
    {'titulo': 'Comidas Típicas', 'imagen': 'assets/images/comida.png'},
    {'titulo': 'Festividades', 'imagen': 'assets/images/festividades.png'},
    {'titulo': 'Lugares Turísticos', 'imagen': 'assets/images/lugares.png'},
    {'titulo': 'Inventos Colombianos', 'imagen': 'assets/images/inventos.png'},
    {'titulo': 'Personajes Históricos', 'imagen': 'assets/images/personajes.png'},
    {'titulo': 'Deportes', 'imagen': 'assets/images/deportes.png'},
    {'titulo': 'Animales Nacionales', 'imagen': 'assets/images/animales.png'},
    {'titulo': 'Cine Latino', 'imagen': 'assets/images/cine.png'},
    {'titulo': 'Idiomas del Mundo', 'imagen': 'assets/images/idiomas.png'},
    {'titulo': 'Famosos del Mundo', 'imagen': 'assets/images/famosos.png'},
    {'titulo': 'Trivia Random', 'imagen': 'assets/images/random.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final categoriasFiltradas = categorias.where((cat) {
      final titulo = cat['titulo']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return titulo.contains(query);
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: const Text(
          'TRIVIA X',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo2.png',
              fit: BoxFit.cover,
            ),
          ),

          //Todo el contenido
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      '¡Juega & Gana!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Barra 
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) =>
                            setState(() => _searchQuery = value),
                        decoration: const InputDecoration(
                          hintText: 'Buscar categoría...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
 //Grid 
GridView.builder(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1,
  ),
  itemCount: categoriasFiltradas.length,
  itemBuilder: (context, index) {
    final categoria = categoriasFiltradas[index];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
onTap: () {
  if (categoria['titulo'] == 'Cultura Colombiana') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GamePage(categoria: categoria['titulo']!),
      ),
    );
  }
},

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(categoria['imagen']!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.darken,
            ),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          categoria['titulo']!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  },
),
const SizedBox(height: 100),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      //Barra
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
    setState(() => _currentIndex = index);

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GamePage(categoria: 'Cultura Colombiana'),
        ),
      );
    }
  },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined), label: 'Trofeo'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'TriviaX'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Tienda'),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.pinkAccent,
                child: Text('A', style: TextStyle(color: Colors.white)),
              ),
              label: 'Perfil'),
        ],
      ),
    );
  }
}

