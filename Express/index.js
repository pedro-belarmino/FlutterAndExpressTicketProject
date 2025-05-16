
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

const TICKETS_FILE = path.join(__dirname, 'data', 'tickets.json');

// Função auxiliar para ler os ingressos
function readTickets() {
    try {
        if (!fs.existsSync(TICKETS_FILE)) return [];
        const data = fs.readFileSync(TICKETS_FILE, 'utf-8').trim();
        return data ? JSON.parse(data) : [];
    } catch (err) {
        console.error('JSON inválido. Recriando arquivo...');
        fs.writeFileSync(TICKETS_FILE, '[]'); // recria com array vazio
        return [];
    }
}

// Função auxiliar para salvar os ingressos
function saveTickets(tickets) {
    fs.writeFileSync(TICKETS_FILE, JSON.stringify(tickets, null, 2));
}

// Rota para cadastrar ingresso
app.post('/tickets', (req, res) => {
    const { name, cpf, email, area } = req.body;
    if (!name || !cpf || !email || !area) {
        return res.status(400).json({ message: 'Campos obrigatórios ausentes.' });
    }
    const newTicket = { name, cpf, email, area };
    const tickets = readTickets();
    tickets.push(newTicket);
    saveTickets(tickets);
    res.status(201).json({ message: 'Ingresso cadastrado com sucesso.', ticket: newTicket });
});

// Rota para buscar ingressos por área
app.get(`/tickets/:area`, (req, res) => { //se não funcionar colocar ${}
    const area = req.params.area.toLowerCase();
    const tickets = readTickets();
    const filtered = tickets.filter(t => t.area.toLowerCase() === area);
    res.json(filtered);
});

app.listen(PORT, () => {
    console.log(`API de ingressos rodando em http://localhost:${PORT}`);
});


