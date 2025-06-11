const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());
const db = mysql.createConnection({
 host: '127.0.0.1',
 user: 'root',
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
        SELECT Id_Compte, Nom_Compte
        FROM COMPTE, ADMINISTRATEUR 
        WHERE 1=1
    `;
    let params = [];
    
    query += ` AND Nom_Compte = ? `;
    params.push(`%${nom}%`);

    query += ` AND Mdp_Compte = ? `;
    params.push(`${mdp}`);

    query += ` AND ADMINISTRATEUR.Id_Compte = (SELECT Id_Compte FROM COMPTE WHERE Nom_Compte = ?) `;
    params.push(`${nom}`);
    
    db.query(query, params, (err, result) => {
        if (err) throw err;
        res.json(result);
    });
});

app.listen(3000, () => {
console.log('Serveur en écoute sur le port 3000');
});