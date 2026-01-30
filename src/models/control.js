const db = require('../config/db')

class Control {
  constructor({ device_id, command, data }) {
    this.id = Date.now().toString()
    this.device_id = device_id
    this.command = command
    this.data = data
  }

  async save() {
    await db.read()
    db.data.controls.push(this)
    await db.write()
    return this
  }
}

module.exports = Control
