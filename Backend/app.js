
const path = require('path');
const express = require('express')
const {spawn} = require('child_process');

const app = express()
const port = 3000
const robot_script = path.join(__dirname, '/main.py');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//TODO: Comentar las funciones con el convenio JSDoc
// Url: https://www.jetbrains.com/help/rider/Creating_JSDoc_Comments.html

app.post('/texto', (req, res) => {
  const FelipeTexto = req.body.texto
})


app.get('/camera', (req, res) => {
  const python = spawn('python', [robot_script]);
  var dataToSend;
  
  python.stdout.on('data', function (data) {
   dataToSend = data.toString();
  });

  python.on('close', (code) => {
    console.log(`child process close all stdio with code ${code}`);
    res.send(dataToSend)
  });
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
