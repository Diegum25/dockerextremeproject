const express = require('express')
const app = express()
const port = 3000

var coolNumber = 0

app.get('/', (req, res) => {
  res.send(`Hello GET! ${coolNumber++}`)
})

app.post('/', (req, res) => {
  res.send(`Hello POST! ${coolNumber++}`)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

app.use('/cool',express.static('public'))