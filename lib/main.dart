import 'package:flutter/material.dart'; 
import 'screens/login_screen.dart'; 
import 'screens/about_screen.dart'; 
  
void main() { 
  runApp(const KatalogApp()); 
} 
  
class KatalogApp extends StatelessWidget { 
  const KatalogApp({super.key}); 
  
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Katalog Sofia Bouquet', 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData( 
        colorSchemeSeed: Colors.pink,
        useMaterial3: true, 
      ), 
      initialRoute: '/', 
      routes: { 
        '/': (context) => const LoginScreen(), 
        '/about': (context) => const AboutScreen(), 
      }, 
    ); 
  } 
} 