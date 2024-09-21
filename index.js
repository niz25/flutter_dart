const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Configuração do body-parser para lidar com dados JSON
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Configuração da conexão com o banco de dados MySQL
const connection = mysql.createConnection({
  host: '143.106.241.3',
  user: 'cl202203',
  password: 'cl*25042007',
  database: 'cl202203'
});

// Conexão ao banco de dados MySQL
connection.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err.stack);
    return;
  }
  console.log('Conectado ao banco de dados MySQL.');
});

// Rota para autenticar um usuário
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const AUTH_USER_QUERY = 'SELECT * FROM SyLoginMobile WHERE username = ? AND password = ?';

  connection.query(AUTH_USER_QUERY, [username, password], (err, results) => {
    if (err) {
      console.error('Erro ao autenticar usuário:', err.stack);
      res.status(500).send('Erro ao autenticar usuário.');
      return;
    }

    if (results.length > 0) {
      res.status(200).json({ message: 'Usuário autenticado com sucesso.' });
    } else {
      res.status(401).json({ message: 'Login ou senha incorretos.' });
    }
  });
});

// Iniciar o servidor Express
app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
