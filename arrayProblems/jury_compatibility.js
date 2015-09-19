function jury_compability(N, M, votes) {
  var results = new Array(N);
  establishUncontested(votes, results);
  return results;
}

function establishUncontested(votes, results) {
  var indices;
  votes.forEach(function(vote) {
    updateUncontested(vote, results);
  });
}

function updateUncontested(vote, results) {
  var indices = vote.map(function(vote) { return Math.abs(vote) - 1; });
  for (var i = 0; i < vote.length; i++) {
    if (results[indices[i]] === undefined) {
      results[indices[i]] = vote[i] / Math.abs(vote[i]);
    } else if (!sameSign(results[indices[i]], votes[i])) {
      results[indices[i]] = 0;
    }
  }
}

function consistentVotes(votes, results) {
  var indices = votes.map(function(vote) { return Math.abs(vote) - 1; });
  var result1 = !votes[0] || sameSign(votes[0], results[indices[0]]);
  var result2 = !votes[1] || sameSign(votes[1], results[indices[1]]);
  return result1 || result2;
}

function sameSign(x, y) {
  return x === 0 && y === 0 ||
    x > 0 && y > 0 ||
    x < 0 && y < 0;
}

var votes = [[1, 2]];
console.log(jury_compability(votes.length * 2, votes.length, votes))
