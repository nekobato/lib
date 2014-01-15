express = require "express"
moment = require "moment"
http = require "http"
path = require "path"
fs = require "fs"
_ = require "underscore"

app = express()

app.set "port", process.env.PORT or 3010
app.set "view engine", "jade"
app.use express.favicon(__dirname + '/dist/favicon.ico', {maxAge: 2592000000})
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.static(path.join(__dirname, "dist"))
app.use app.router
app.disable 'x-powered-by'

app.use express.errorHandler() if "development" is app.get("env")

data = require datafile = "./data.json"

# time reload
reloadTime = () ->
	moment().format 'ddd, DD MMM YYYY HH:mm:ss ZZ'
reload = reloadTime()

#routes
app.get "/", (req, res) ->
	res.render 'index', {article: data[0], data: data, index: true}
	@
app.get "/article/:id", (req, res) ->
	article = _.where data, {id: req.params.id}
	res.render 'index', {article: article[0], data: data}
	@
app.get "/api/:id", (req, res) ->
	return if typeof(req.params.id) is not 'number' and typeof(req.params.id) is not 'string'
	console.log req.params.id
	logfile = './data/log_' + req.params.id
	res.send fs.readFileSync(logfile, 'utf-8') if fs.existsSync logfile
	@
app.post "/comment/", (req, res) ->
	console.log req.body.id
	return req.body.id if typeof(req.body.id) is not 'number' and typeof(req.body.id)
	target = _.where data, {id: req.body.id}
	comment = {body: req.body.body, time: moment().format()}
	target[0].comments.push comment if target
	fs.writeFile datafile, JSON.stringify(data, null, 2), (err) ->
		if ! err
			res.send JSON.stringify {result: true, comment: comment }
		else 
			res.send JSON.stringify {result: false, error: "data update error"}
	@
app.get "/rss", (req, res) ->
	@rssdata = []
	for d in data[0...9]
		d.article = fs.readFileSync("./data/log_#{d.id}", 'utf-8')
		@rssdata.push d
	res.render 'rss', {pubDate: reload, data: @rssdata}
	@

# watch file start
fs.watch datafile, (e, file) ->
	console.log 'datafile changed.'
	data = require datafile
	reload = reloadTime()

# http server start
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
