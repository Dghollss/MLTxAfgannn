const db = require('../config/db');

class User {
  constructor({ email, password, role }) {
    this.id = Date.now().toString();
    this.email = email;
    this.password = password;
    this.role = role || 'parent';
  }

  async save() {
    db.data.parents.push(this);
    await db.write();
    return this;
  }

  static async findOne(query) {
    return db.data.parents.find(u => u.email === query.email && u.password === query.password);
  }
}

module.exports = User;
