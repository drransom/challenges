function jury_compability(N, M, votes) {
  return new ConflictChecker(votes, N).checkConflicts();
}

function ConflictChecker(juries, numOptions) {
  this.numOptions = numOptions;
  this.juries = juries;
  this.votes = {};
  this.mandatory = {};
}

ConflictChecker.prototype.otherCheckConflicts = function() {
  var result;
  this.constructVoteMap();
  for (var j = 0; j < 2; j++) {
    for (var i = 0; i <= numOptions; i++) {
      if (!this.updateKey(i, this.voteMap[i])) {
        return false;
      }
      if (!this.updateKey(-i, this.voteMap[-i])) {
        return false;
      }
    }
  }
  return true;
};

ConflictChecker.prototype.updateKey = function(key, map, revalidate = false) {
  for (var value in this.voteMap[key]) {
    if (!map[value] || !revalidate) {
      map[value] = true;
      if (map[-value]) {
        return false;
      }
      this.updateKey(map, value, true);
    }
  }
};

ConflictChecker.prototype.checkConflicts = function() {
  return this.updateAndCheckConflicts() && this.updateAndCheckConflicts();
};

ConflictChecker.prototype.updateAndCheckConflicts = function() {
  var jury;
  for (var i = 0; i < this.juries.length; i++) {
    jury = this.juries[i];
    this.updateVotes(jury);
    if (this.hasConflict(jury)) {
      return false;
    }
  }
  return true;
};

ConflictChecker.prototype.updateVotes = function(jury) {
  for (var i = 0; i < jury.length; i++) {
    vote = jury[i];
    this.votes[vote] = true;
    if (this.votes[-vote]) {
      other = jury[(i + 1) % 2];
      this.mandatory[other] = true;
    }
  }
};

ConflictChecker.prototype.hasConflict = function(jury) {
  return this.mandatory[-jury[0]] && this.mandatory[-jury[1]];
};

ConflictChecker.prototype.printVotes = function() {
  console.log("votes is currently: ");
  for (var property in this.votes) {
    console.log(property + ": " + this.votes[property]);
  }
};

ConflictChecker.prototype.printMandatory = function() {
  console.log("mandatory is currently: ");
  for (var property in this.mandatory) {
    console.log(property + ": " + this.mandatory[property]);
  }
};

ConflictChecker.prototype.constructVoteMap = function() {
  this.createVoteMapObject();
  this.jurors.forEach(function(juror) {
    for (var i = 0; i < 2; i++) {
      this.voteMap[-juror[i]][juror[(i + 1) % 2]] = true;
    }
  }.bind(this));
};

ConflictChecker.prototype.createVoteMapObject = function() {
  this.voteMap = {};
  for (var i = 1; i <= this.numOptions; i++) {
    this.voteMap[i] = {};
    this.voteMap[-i] = {};
  }
};

var jury = [[1, 2], [1, -2], [-1, 3]];
console.log(jury_compability(3,3,[[1,2],[-1,-2],[1,3]]));




// function establishUncontested(votes, results) {
//   var indices;
//   votes.forEach(function(vote) {
//     updateUncontested(vote, results);
//   });
// }
//
// function updateUncontested(jury, results) {
//   var indices = jury.map(function(vote) { return Math.abs(vote) - 1; });
//   for (var i = 0; i < jury.length; i++) {
//     if (results[indices[i]] === undefined) {
//       results[indices[i]] = jury[i] / Math.abs(jury[i]);
//     } else if (!sameSign(results[indices[i]], jury[i])) {
//       results[indices[i]] = 0;
//     }
//   }
// }
//
// function establishContested(votes, results) {
//
// }
//
// function jurySatisfied(jury, results) {
//   var indices = jury.map(function(vote) { return Math.abs(vote) - 1; });
//   var result1 = results[indices[0]] !== undefined && sameSign(jury[0], results[indices[0]]);
//   var result2 = results[indices[1]] !== undefined && sameSign(jury[1], results[indices[1]]);
//   return result1 || result2;
// }
//
// function sameSign(x, y) {
//   return x === 0 && y === 0 ||
//     x > 0 && y > 0 ||
//     x < 0 && y < 0;
// }
//
// function oppositeSign(x, y) {
//   return x && y && !sameSign(x, y);
// }
//
// function Jury(votes, results) {
//   this.votes = votes;
//   this.results = results;
//   this.conflicted = false;
//   this.indices = votes.map(function(vote) { return Math.abs(vote) - 1; });
// }
//
// Jury.prototype.isSatisfied = function() {
//   for (var i = 0; i < this.votes.length; i++) {
//     if (sameSign(this.votes[i], this.results[this.indices[i]])) {
//       return true;
//     }
//   }
//   return false;
// };
//
// Jury.prototype.cannotBeSatisfied = function() {
//   for (var i = 0; i < this.votes.length; i++) {
//     if (oppositeSign(this.votes[i], this.results[this.indices[i]])) {
//       return true;
//     }
//   }
//   return false;
// };
//
// function ConflictClass(juries, index) {
//   this.juries = juries;
//   this.startIndex = index;
//   this.currentJury = juries[index];
//   this.conflictedJuries = [];
//   this.conflictsHash = {};
//   this.calculateConflicts();
// }
//
// ConflictClass.prototype.calculateConflicts = function() {
//   for (var i = this.startIndex; i < this.juries.length; i++) {
//     updateConflicts(jury);
//   }
// };
