const express = require('express');
const fs = require('fs');
const exec = require('child_process').exec;
const path = require('path');
const app = express();
const port = 8080;

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Generate ingresses.json
function generateIngressesJson(callback) {
    exec('/app/list_ingress.sh', (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing script: ${error}`);
            return callback(error);
        }
        console.log(`Script executed: ${stdout}`);
        callback(null);
    });
}

// Endpoint to serve ingresses.json
app.get('/ingresses.json', (req, res) => {
    const jsonFilePath = '/tmp/ingresses.json';
    fs.readFile(jsonFilePath, (err, data) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error reading JSON file');
        }
        res.setHeader('Content-Type', 'application/json');
        res.send(data);
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
    generateIngressesJson((err) => {
        if (err) {
            console.error('Failed to generate JSON file');
        } else {
            console.log('JSON file generated successfully');
        }
    });
});
