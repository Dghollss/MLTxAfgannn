const router = require('express').Router()
const auth = require('../middlewares/auth.middleware')
const { registerDevice, getDevices } = require('../controllers/device.controller')

router.post('/register', auth, registerDevice)
router.get('/list', auth, getDevices)

module.exports = router
