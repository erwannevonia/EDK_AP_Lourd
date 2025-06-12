const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());
const db = mysql.createConnection({
 host: '172.16.198.254',
 user: 'edk-selector',
 password: 't',
 database: 'EDK'
});

db.connect(err => {
 if (err) throw err;
 console.log('Base de données connectée');
});

app.get('/users', (req, res) => {
 db.query(`
            SELECT * 
            FROM COMPTE
            `, (err, result) => {
  if (err) throw err;
  res.json(result);
 });
});

app.get('/user', (req, res) => {
    const { nom, mdp } = req.query;

    let query = `
        SELECT COMPTE.Id_Compte, Nom_Compte
        FROM COMPTE, ADMINISTRATEUR 
        WHERE 1=1
    `;
    let params = [];
    
    query += ` AND Nom_Compte = ? `;
    params.push(`${nom}`);

    query += ` AND Mdp_Compte = ? `;
    params.push(`${mdp}`);

    query += ` AND ADMINISTRATEUR.Id_Compte = (SELECT Id_Compte FROM COMPTE WHERE Nom_Compte = ?) `;
    params.push(`${nom}`);
    
    db.query(query, params, (err, result) => {
        if (err) throw err;
        res.json(result);
    });
});

app.get('/eleves', (req, res) => {

    let query = `
        SELECT com.Id_Compte, com.Nom_Compte, com.Mail_Compte, com.Id_Classe, com.A2F
        FROM COMPTE com  
        JOIN CLASSE cla ON com.Id_Classe = cla.Id_Classe
        WHERE cla.Id_Classe = com.Id_Classe 
    `;
    
    db.query(query, (err, result) => {
        if (err) throw err;
        res.json(result);
    });
});

app.put('/utilisateurs/:id/mdp', (req, res) => {
  const id = req.params.id;
  const { mdp } = req.body;

  let query = ` UPDATE COMPTE SET `;
  let params = [];

  query += ` Mdp_Compte = ? `;
  params.push(`${mdp}`);

  query += ` WHERE Id_Compte = ? `;
  params.push(`${id}`);
  db.query(query, params, (err, result) => {
  if (err) return res.status(500).json({ error: 'Erreur serveur' });
  if (result.affectedRows === 0) {
    return res.status(404).json({ error: 'Aucun compte trouvé avec cet ID' });
  }
  res.json({ message: 'Mot de passe mis à jour' });
});
});

app.delete('/utilisateurs/:id', (req, res) => {
  const id = req.params.id;
  let query = `DELETE FROM COMPTE WHERE 1=1 `;
  let params = [];

  query += ` AND Id_Compte = ? `;
  params.push(`${id}`);
  
  db.query(query, params, (err, result) => {
    if (err) return res.status(500).json({ error: 'Erreur serveur' });
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Aucun compte trouvé avec cet ID' });
    }
    res.status(200).json({ message: 'Compte supprimé' });
  });
});


// Route pour supprimer un professeur
app.delete('/utilisateurs/:id', (req, res) => {
  const id = req.params.id;
  let query = ` DELETE FROM COMPTE_MATIERE WHERE Id_Compte = ?; `;
  let params = [];
  params.push(`${id}`);

  query += ` DELETE FROM POSSEDER WHERE Id_Compte = ?; `;
  params.push(`${id}`);

  query += ` DELETE FROM PROFESSEUR WHERE Id_Compte = ?; `;
  params.push(`${id}`);

  query += ` DELETE FROM COMPTE WHERE Id_Compte = ?; `;
  params.push(`${id}`);
  
  db.query(query, params, (err, result) => {
    if (err) return res.status(500).json({ error: 'Erreur serveur' });
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Aucun compte trouvé avec cet ID' });
    }
    res.status(200).json({ message: 'Compte supprimé' });
  });
});

app.listen(3000, () => {
console.log('Serveur en écoute sur le port 3000');
});