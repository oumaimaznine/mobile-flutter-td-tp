const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const port = 3000;

app.use(bodyParser.json());

const loadData = () => JSON.parse(fs.readFileSync('data.json', 'utf8'));
const saveData = (data) => fs.writeFileSync('data.json', JSON.stringify(data, null, 2));

app.get('/', (req, res) => res.send('API Backend fonctionne!'));

app.listen(port, () => console.log(`Serveur API démarré sur http://localhost:${port}`));
// Route pour récupérer tous les produits
app.get('/products', (req, res) => {
    res.json(loadData().products);
  });
  
  // Route pour ajouter un produit
  app.post('/products', (req, res) => {
    const data = loadData();
    data.products.push(req.body);
    saveData(data);
    res.status(201).send('Produit ajouté');
  });
  
  // Route pour récupérer toutes les commandes
  app.get('/orders', (req, res) => {
    res.json(loadData().orders);
  });
  
  // Route pour ajouter une commande
  app.post('/orders', (req, res) => {
    const data = loadData();
    data.orders.push(req.body);
    saveData(data);
    res.status(201).send('Commande créée');
  });