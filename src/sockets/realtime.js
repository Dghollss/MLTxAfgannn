const io = global.io

function sendCommand(device_id, payload){
  io.emit('command', { device_id, ...payload })
}

module.exports = { sendCommand }
