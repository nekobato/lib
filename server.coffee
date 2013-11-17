express = require "express"
http = require "http"
path = require "path"
app = express()
fs = require "fs"
_ = require "underscore"
moment = require "moment"

app.set "port", process.env.PORT or 3005
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon(__dirname + '/public/favicon.ico', {maxAge: 2592000000})
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use require("stylus").middleware(__dirname + "/public")
app.use express.static(path.join(__dirname, "public"))
app.disable 'x-powered-by'

app.use express.errorHandler()  if "development" is app.get("env")

data = require "./data.json"

#routes
app.get "/", (req, res) ->
	res.render 'index', {article: data[0], data: data}
	@
app.get "/article/:id", (req, res) ->
	article = _.where data, {id: req.params.id}
	res.render 'index', {article: article[0], data: data}
	@
app.get "/api/:id", (req, res) ->
	return if typeof(x) is not 'number' and typeof(x) is not 'string'
	console.log req.params.id
	logfile = './data/log_' + req.params.id
	res.send fs.readFileSync(logfile, 'utf-8') if path.existsSync logfile
	@
app.get "/rss", (req, res) ->
	res.render 'rss', {data:data}
	@

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

