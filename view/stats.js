var user = require('../lib/resources/user'),
    hook = require('../lib/resources/hook'),
    request = require('request');

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/*

 todo: consider adding route caching to resource-http
 
 var routeCache = require('route-cache');

 // cache route for 20 seconds 
 app.get('/index', routeCache.cacheSeconds(20), function(req, res){
     // do your dirty work here... 
     console.log('you will only see this every 20 seconds.');
     res.send('this response will be cached');
 });

*/

module['exports'] = function view (opts, callback) {
  var $ = this.$;
  user.all(function(err, results){
    $('.activeUsers').html(results.length)
    hook.all(function(err, results){
      $('.activeServices').html(results.length);
      var count = 0;
      results.forEach(function(h){
        count += h.ran;
      });
      $('.totalRun').html(numberWithCommas(count));
      request('https://api.github.com/repos/bigcompany/hook.io', {
        headers: {
          "User-Agent": "hook.io stats"
        },
        json: true
      }, function (err, res, output) {
        if (err) {
          console.log(err.message);
        }
        $('.githubStars').html(output.stargazers_count);
        $('.projectForks').html(output.forks_count);
        callback(null, $.html());
      });
    });
  });
};