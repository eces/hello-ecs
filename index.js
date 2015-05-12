express = require('express')

app = module.exports.app = express()

http = require('http').Server(app)
http.listen(app.get('port'), function(){
    console.log('Listen: ' + app.get('port'))
});