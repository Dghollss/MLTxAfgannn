const express = require('express')
const path = require('path')
const app = express()

app.use(express.json())
app.use(express.static(path.join(__dirname,'public')))

const authRoutes = require('./routes/auth.routes')
const deviceRoutes = require('./routes/device.routes')
const controlRoutes = require('./routes/control.routes')

app.use('/api/auth', authRoutes)
app.use('/api/device', deviceRoutes)
app.use('/api/control', controlRoutes)

module.exports = app
