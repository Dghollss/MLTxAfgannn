const app = require('./app');
const http = require('http');
const { Server } = require('socket.io');

const server = http.createServer(app);
const io = new Server(server);

global.io = io; // biar bisa dipake di controller/socket lain

io.on('connection', (socket) => {
  console.log('New socket connected:', socket.id);
});

server.listen(5000, () => {
  console.log('Server running on port 5000');
});
