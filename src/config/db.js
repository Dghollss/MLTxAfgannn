nano models/user.js nano models/device.js nano models/control.js nano 
controllers/auth.controller.js nano controllers/device.controller.jsconst { Low, JSONFile } = 
require('lowdb'); nano controllers/control.controller.js nano routes/auth.routes.js// Setup 
adapter & default data const adapter = new JSONFile('./family_db.json'); const db = new 
Low(adapter); nano routes/device.routes.js nano routes/control.routes.js// Default data awal 
db.data = db.data || { nano sockets/realtime.js parents: [],
nano public/index.html  children: [],
  devices: [],
  controls: []
};

// Inisialisasi database
async function initDB() {
  await db.read();
  await db.write();
}

initDB();

module.exports = db;
