var gzip = require('gulp-gzip');
var compress = require('gulp-uglify');
var gulp = require('gulp');

gulp.task('compress', ['browserify'], function() {
  return gulp.src('dist/js/*.js')
    .pipe(compress())
 //   .pipe(gzip())
    .pipe(gulp.dest('dist/js/'));
});
