const express = require('express')
const websocket = require("ws")
const crypto = require("crypto")

const app = express()

const apiPort = Number(process.env.EXTREME_BACKEND_PORT)

app.use(express.text())

if (isNaN(apiPort)){
  console.error(`Port is NaN!\nSet EXTREME_BACKEND_PORT to something`)
  process.exit(1)
}

// This probably no longer works
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

app.get('/test',(req,res) => {
  res.send("HI")
})

const s = app.listen(apiPort, () => {
  console.log(`Backend listening on port ${apiPort}`)
})

// socket stuff
const socketServer = new websocket.WebSocketServer({noServer: true})

s.on('upgrade',(req, socket, head) => {
  socketServer.handleUpgrade(req,socket,head,(ws) => {
    socketServer.emit('connection',ws,req)
  })
})

const players = new Map()

socketServer.on('connection',(ws, req)=>{
  const id = crypto.randomUUID()
  console.log(`${id} connected!`)

  // 3. Listen for messages coming from the client
  ws.on('message', (data) => {
    try{
      const dataObj = JSON.parse(data.toString())

      if (dataObj.type === "posData"){
        players.set(id,{
          "xyz": dataObj.xyz
        })
      }
      const allPlayersData = Object.fromEntries(players);

      socketServer.clients.forEach((client)=>{
        if (client.readyState == websocket.OPEN && client != ws){
          const response = {
            "type": 'posDataAll',
            "data": allPlayersData
          }
          client.send(JSON.stringify(response))
        }
      })

    }catch(err){
      console.error(err)
    }
  });

  ws.on('close',()=>{
    console.log(`${id} disconnected :(`)
    players.delete(id)
  })
})