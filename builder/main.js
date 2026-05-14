const execa = require('execa');

const express = require('express')
const app = express()
var port = Number(process.env.EXTREME_BUILDER_PORT)

if (isNaN(port)){
  console.error(`Port is NaN!\nSet EXTREME_BUILDER_PORT to something`)
  console.log('Using port 2167')

  port = 2167
}

app.use(express.text())

app.post('/:filename', async(req, res) => {
  const filename = req.params.filename;
  console.log(`Receiving file: ${filename}`);

  const gccanswer = await execa.execa("echo",[req.body]).pipe("gcc",["-x", "c", "-"]);

  const outgcc = gccanswer.stdout
  const errgcc = gccanswer.stderr

  const execanswer = await execa.execa("./a.out");

  const execout = execanswer.stdout
  const execerr = execanswer.stderr

  execa.execa("rm",["./a.out"]) // kinda nasty

  console.log(execout,execerr);

  res.send(`{"stdout": "${execout}","stderr": "${execerr}"}\n`);
});

app.listen(port, () => {
  console.log(`Builder listening on port ${port}`)
})