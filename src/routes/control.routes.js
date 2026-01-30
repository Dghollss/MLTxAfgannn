const router = require('express').Router()
const auth = require('../middlewares/auth.middleware')
const { sendControl } = require('../controllers/control.controller')

router.post('/send', auth, sendControl)

module.exports = router
