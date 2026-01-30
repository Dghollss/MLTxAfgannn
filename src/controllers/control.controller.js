const Control = require('../models/control')
const { sendCommand } = require('../sockets/realtime')

exports.sendControl = async (req,res)=>{
  try{
    const { device_id, command, data } = req.body
    const control = new Control({ device_id, command, data })
    await control.save()

    sendCommand(device_id, { command, data })
    res.json({ msg:"Command sent" })
  }catch(err){
    res.status(500).json({ error: err.message })
  }
}
