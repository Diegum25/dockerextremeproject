const express = require('express')
const ws = require("ws")
const dgram = require("dgram")

const app = express()

const apiPort = Number(process.env.EXTREME_BACKEND_PORT)
const webPort = Number(process.env.EXTREME_BACKEND_WS_PORT)
const udpPort = Number(process.env.EXTREME_BACKEND_UDP_PORT)

app.use(express.text())

if (isNaN(apiPort)){
  console.error(`Port is NaN!\nSet EXTREME_BACKEND_PORT to something`)
  process.exit(1)
}

if (isNaN(webPort)){
  console.error(`Port is NaN!\nSet EXTREME_BACKEND_WS_PORT to something`)
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

app.get('/test',(req,res) => {
  res.send("HI")
})

app.listen(apiPort, () => {
  console.log(`Backend listening on port ${apiPort}`)
})

// socket stuff

const socketServer = new ws.WebSocketServer({port: webPort})
console.log(`WebSocket server is running on port ${webPort}`);

var messages = [];

socketServer.on('connection',(ws)=>{
  console.log("Connected")

  ws.send('You are connected!');

  // 3. Listen for messages coming from the client
  ws.on('message', (data) => {
    dataStr = data.toString()
    console.log(dataStr);
    messages.push(dataStr)

    const response = {
      "messages" : messages
    }
    
    socketServer.clients.forEach((client)=>{
      if (client.OPEN){
        client.send(JSON.stringify(response));
      }
    })

  });

  ws.on('close',()=>{
    console.log("Disconnected")
  })
})

// UDP stuff

const udpServer = dgram.createSocket('udp4')

const clients = new Map()

udpServer.on('message',(msg, rinfo)=>{
  console.log(`Got ${msg.toString()} from ${rinfo.address}:${rinfo.port}`)

  const clientID = `${rinfo.address}:${rinfo.port}`

  if (!clients.has(clientID)){
    console.log(`Someone connected :D`)
    udpServer.send(Buffer.from('Welcome :D'),rinfo.port,rinfo.address)
  }

  clients.set(clientID,Date.now())
})

udpServer.bind(udpPort,'0.0.0.0',()=>{
  console.log(`UDP server is running on port ${udpPort}`)
})

setInterval(()=>{
  const now = Date.now()

  for(const [clientID, lastSeen] of clients.entries()){
    if(now - lastSeen > 5000){
      console.log(`${clientID} disconnected :(`)
      sendToAllClients(`${clientID} disconnected :(`)
      clients.delete(clientID)
    }
  }

},2000)

function sendToAllClients(message){
  for(const [clientID, lastSeen] of clients.entries()){

    const [addr,port] = String(clientID).split(':')

    udpServer.send(message,port,addr)
  }
}