import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _error = '';
  bool _showSuggestion = false;

  //Datos
  final String savedUser = 'alejaa_aguilar';
  final String savedPass = '1234';

  void _login() {
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (user == savedUser && pass == savedPass) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = 'Usuario o contraseña incorrecta');
    }
  }

  void _autocompletar() {
    setState(() {
      _userCtrl.text = savedUser;
      _passCtrl.text = savedPass;
      _showSuggestion = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          //Fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo.gif',
              fit: BoxFit.cover,
            ),
          ),

          //Capa oscura
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //Imagen sup
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/personaje.gif',
                      height: 200,
                    ),
                  ),

                  //Tarjeta
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'PREGUNTADOS',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 25),

                        //Usuario
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                TextField(
                                  controller: _userCtrl,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Usuario',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        savedUser.startsWith(value)) {
                                      setState(() => _showSuggestion = true);
                                    } else {
                                      setState(() => _showSuggestion = false);
                                    }
                                  },
                                ),
                                if (_showSuggestion)
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(Icons.account_circle,
                                          color: Colors.purple),
                                      title: Text(savedUser,
                                          style:
                                              const TextStyle(fontSize: 15)),
                                      onTap: _autocompletar,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        //Contraseña
                        TextField(
                          controller: _passCtrl,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                        ),

                        if (_error.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _error,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '¿No tienes cuenta? Regístrate',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
