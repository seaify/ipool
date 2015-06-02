var gulp = require('gulp');
var connect = require('gulp-connect');
//var connect = require('connect');
var config = require('../config').server;
var gzip = require('connect-gzip');

gulp.task('server', function() {
  connect.server(config.settings);
});

/*
gulp.task('server', function() {
  connect.createServer(
    gzip.staticGzip('dist')
  ).listen(8103);
});
*/
