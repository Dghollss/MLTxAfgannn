const db = require('../config/db')

class Device {
  constructor({ device_id, device_name, user_id, status }) {
    this.device_id = device_id
    this.device_name = device_name
    this.user_id = user_id
    this.status = status || 'offline'
  }

  async save() {
    await db.read()
    db.data.devices.push(this)
    await db.write()
    return this
  }

  static async find(query) {
    await db.read()
    return db.data.devices.filter(d => d.user_id === query.user_id)
  }

  static async findById(device_id) {
    await db.read()
    return db.data.devices.find(d => d.device_id === device_id)
  }
}

module.exports = Device
