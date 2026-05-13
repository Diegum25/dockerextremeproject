const express = require('express')
const app = express()
const port = Number(process.env.EXTREME_BACKEND_PORT)

var coolNumber = 0

app.get('/', (req, res) => {
  res.send(`Hello GET! ${coolNumber++}`)
})

app.post('/', (req, res) => {
  res.send(`Hello POST! ${coolNumber++}`)
})

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`)
})