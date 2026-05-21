const express = require('express')
const app = express()
const port = Number(process.env.EXTREME_BACKEND_PORT)

app.use(express.text())

if (isNaN(port)){
  console.error(`Port is NaN!\nSet EXTREME_BACKEND_PORT to something`)
  process.exit(1)
}

async function InferHost(){ // dumb
    if (process.env.EXTREME_HOST_DOCKER == '1'){
        return "builder"
    }else{
        return "localhost"
    }
}

app.post('/code', async (req, res) => {

  const host = await InferHost()
      
  const builder = `http://${host}:${process.env.EXTREME_BUILDER_PORT}`;

  const response = await fetch(builder+"/build",{method:"POST", body:req.body, headers:[['content-type','text/plain']]})

  const responseData = await response.json()

  res.send(responseData)
})

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`)
})