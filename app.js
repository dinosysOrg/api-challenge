var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var info = require('./routes/info');
var upload = require('./routes/upload');

var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

mysql = require("mysql");
const config = require("./config.js");
var connection = mysql.createConnection({
  host     :  config.host,
  user     :  config.user,
  password : 	config.password,
  database : 	config.database
});

 connection.connect(err => {
  if (err) {
    console.log('error connecting: ' + err.stack);
    return;
  }
  app.set("mysql", connection)
  console.log('connected to database');

});
app.use('/info', info);
app.use('/upload', upload);
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
  connection.end();
});

module.exports = app;
