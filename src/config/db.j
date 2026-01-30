const { Low } = require('lowdb')
const { JSONFile } = require('lowdb/node')

const adapter = new JSONFile('./family_db.json')
const defaultData = {
  parents: [],
  children: [],
  devices: [],
  controls: []
}

const db = new Low(adapter, defaultData)

async function initDB(){
  await db.read()
  await db.write()
}

initDB()

module.exports = db
