const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

router.post('/register', authController.registerParent);
router.post('/login', authController.loginParent);

module.exports = router;
