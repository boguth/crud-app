$(document).ready(function() {
  $("a.upvote").on ("click", upvoteRequest);
  $("a.downvote").on ("click", downvoteRequest);
  $(".question-content .edit_button").on ("click", showEditQuestionPartial);
});

function upvoteRequest(event){
    event.preventDefault();
    var earl = $(this).attr("href")
    var ajax_request = $.ajax({
                                method: "GET",
                                url: earl,
                                dataType: "json"
    });
    var current_upvote = $(this)
    ajax_request.done(function(response){
      if (response === "Error") {
        alert("Please log in");
      }
      else if (response.upvoted){
        upvote(response.vote_count,current_upvote);
      }
      else{
        removeUpvote(response.vote_count,current_upvote);
      }
    });
};


function upvote(score,current_upvote){
    current_upvote.next().html(score)
    current_upvote.css({color: "yellow"});
    current_upvote.siblings('.downvote').css({color: 'gray'})
};

function removeUpvote(score, current_upvote){
  current_upvote.next().html(score)
  current_upvote.css({color: "gray"});
};

function downvoteRequest(event){
    event.preventDefault();
    var earl = $(this).attr("href")
    var ajax_request = $.ajax({
                                method: "GET",
                                url: earl,
                                dataType: "json"
    });
    var current_downvote = $(this)
    ajax_request.done(function(response){
      if (response === "Error") {
        alert("Please log in");
      }
      else if (response.downvoted){
        downvote(response.vote_count,current_downvote);
      }
      else{
        removeDownvote(response.vote_count,current_downvote);
      }
    });
};

function downvote(score,current_downvote){
    current_downvote.prev().html(score)
    current_downvote.css({color: "red"});
    current_downvote.siblings('.upvote').css({color: 'gray'})
};

function removeDownvote(score, current_downvote){
  current_downvote.prev().html(score)
  current_downvote.css({color: "gray"});
};

function showEditQuestionPartial(event){
  event.preventDefault();
  var url = $(event.target).attr('action')
  var ajax = $.ajax({
    method: 'GET',
    url: url
  });
  ajax.done(function(data){
    displayQuestionEditForm(data, $(event.target));
  });
};

function displayQuestionEditForm(data, $target){
  $(".question-content").remove();
  target.remove();
  $(".container").perpend(data);
};
