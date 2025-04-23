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
        SELECT Id_Compte, Nom_Compte
        FROM COMPTE
        WHERE 1=1
    `;
    let params = [];
    
    query += ` AND Nom_Compte LIKE ? `;
    params.push(`%${nom}%`);

    query += ` AND Mdp_Compte = ? `;
    params.push(`${mdp}`);
    
    db.query(query, params, (err, result) => {
        if (err) throw err;
        res.json(result);
    });
});

app.listen(3000, () => {
console.log('Serveur en écoute sur le port 3000');
});