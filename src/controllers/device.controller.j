const Device = require('../models/device')

exports.registerDevice = async (req,res)=>{
  try{
    const { device_id, device_name } = req.body
    const device = new Device({
      device_id,
      device_name,
      user_id: req.user.id,
      status:'online'
    })
    await device.save()
    res.json({ msg:"Device registered" })
  }catch(err){
    res.status(500).json({ error: err.message })
  }
}

exports.getDevices = async (req,res)=>{
  try{
    const devices = await Device.find({ user_id:req.user.id })
    res.json(devices)
  }catch(err){
    res.status(500).json({ error: err.message })
  }
}
