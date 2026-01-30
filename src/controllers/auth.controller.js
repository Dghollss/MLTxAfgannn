const jwt = require('jsonwebtoken')
const User = require('../models/user')

exports.register = async (req,res)=>{
  try{
    const { email, password } = req.body
    const user = new User({ email, password, role:'parent' })
    await user.save()
    res.json({ msg:"Parent registered" })
  }catch(err){
    res.status(500).json({ error: err.message })
  }
}

exports.login = async (req,res)=>{
  try{
    const { email, password } = req.body
    const user = await User.findOne({ email, password })
    if(!user) return res.status(400).json({ msg:"Invalid login" })

    const token = jwt.sign(
      { id:user.id, role:user.role },
      process.env.JWT_SECRET || 'secret123'
    )

    res.json({ token })
  }catch(err){
    res.status(500).json({ error: err.message })
  }
}
