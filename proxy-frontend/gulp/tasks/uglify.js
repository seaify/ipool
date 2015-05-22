var uglify = require('gulp-uglify');
var gulp = require('gulp');

gulp.task('compress', ['browserify'], function() {
  return gulp.src('dist/js/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist/js/'));
});
