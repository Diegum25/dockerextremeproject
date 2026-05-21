const crypto = require('crypto')

const UUIDS = new Set()

const execa = require('execa');

const express = require('express');
const app = express()
var port = Number(process.env.EXTREME_BUILDER_PORT)

if (isNaN(port)){
  console.error(`Port is NaN!\nSet EXTREME_BUILDER_PORT to something`)
  process.exit(1)
}

app.use(express.text())

app.use((req,res,next) => {

  do{
    req.id = crypto.randomUUID();
  }while(UUIDS.has(req.id))

  res.on('finish', () => UUIDS.delete(req.id));
  next();
})

app.post('/build', async(req, res) => {

  let response

  const _ = await execa.execa("gcc",["-x", "c", "-", `-o${req.id}`], { input: req.body}).then(async result =>{    
    const execanswer = await execa.execa(`./${req.id}`);

    execa.execa("rm",[`./${req.id}`]) // kinda nasty

    response = {"status": "compiled", "output": {"stdout": execanswer.stdout,"stderr": execanswer.stderr}}
    console.log(response)
  }).catch(err => {
    response = {"status": "failed", "output": {"stdout": err.stdout,"stderr": err.stderr}}
    console.log(response)
  });

  res.send(JSON.stringify(response));
});

app.listen(port, () => {
  console.log(`Builder listening on port ${port}`)
})