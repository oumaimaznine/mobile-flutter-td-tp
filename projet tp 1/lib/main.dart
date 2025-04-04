import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  print(response.body);
  // URL de base de votre API REST
  final String baseUrl = 'http://localhost:3000';

  // Récupérer tous les produits
  print('--- Récupérer les produits ---');
  await getProducts(baseUrl);

  // Ajouter un nouveau produit
  print('\n--- Ajouter un produit ---');
  await addProduct(baseUrl, {'name': 'Produit Test', 'price': 50});

  // Récupérer à nouveau les produits pour vérifier
  print('\n--- Récupérer les produits après ajout ---');
  await getProducts(baseUrl);

  // Récupérer toutes les commandes
  print('\n--- Récupérer les commandes ---');
  await getOrders(baseUrl);

  // Ajouter une nouvelle commande
  print('\n--- Ajouter une commande ---');
  await addOrder(baseUrl, {'product': 'Produit Test', 'quantity': 3});

  // Récupérer à nouveau les commandes pour vérifier
  print('\n--- Récupérer les commandes après ajout ---');
  await getOrders(baseUrl);
}

// Fonction pour récupérer tous les produits
Future<void> getProducts(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/products'));
  if (response.statusCode == 200) {
    List<dynamic> products = jsonDecode(response.body);
    print('Produits disponibles:');
    products.forEach((product) => print('Nom: ${product['name']}, Prix: ${product['price']}'));
  } else {
    print('Erreur lors de la récupération des produits');
  }
}

// Fonction pour ajouter un produit
Future<void> addProduct(String baseUrl, Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(product),
  );
  print(response.statusCode == 201 ? 'Produit ajouté' : 'Erreur');
}

// Fonction pour récupérer toutes les commandes
Future<void> getOrders(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/orders'));
  if (response.statusCode == 200) {
    List<dynamic> orders = jsonDecode(response.body);
    print('Commandes disponibles:');
    orders.forEach((order) => print('Produit: ${order['product']}, Quantité: ${order['quantity']}'));
  } else {
    print('Erreur');
  }
}

// Fonction pour ajouter une commande
Future<void> addOrder(String baseUrl, Map<String, dynamic> order) async {
  final response = await http.post(
    Uri.parse('$baseUrl/orders'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(order),
  );
  print(response.statusCode == 201 ? 'Commande créée' : 'Erreur');
}