$(document).ready(function() {
  $("#login-button").on("submit", function(event){
    event.preventDefault();
    var url = $(this).attr("action");
    var ajax_request = $.ajax({
                                url: url,
                                method: "GET"

    });
    ajax_request.success(function(response){
      $("#header").append(response);
      $("#login-button").hide();
    });
  });

  $(document).on("submit", "#login", function(event){
    event.preventDefault();
    var data = $("#login").serialize();
    var ajax_request = $.ajax({
                                url: "/sessions",
                                method: "POST",
                                data: data

    });
    ajax_request.success(function(response){
      if (response == "Please enter a valid username and password."){
        $("#login").append(response);
      }
      else{
        // $("#header").html(response);
        // $("#main").html("#main");
        location.reload();
      }
    });
  });

  $("#main").on("click", ".edit-link", function(event){
    event.preventDefault();
    var that = $(this)
    var url = $(this).children().attr("href")
    var ajax_request = $.ajax({
                                url: url,
                                method: "GET"
    });

    ajax_request.success(function(response){
      that.prev().append(response);
      that.hide();
    });
  });

  $("#main").on("submit", "#edit-form", function(event){
    event.preventDefault();
    var that = $(this)
    var url = $(this).attr("action")
    var data = $(this).serialize();
    var ajax_request = $.ajax({
                                url: url,
                                method: "PUT",
                                data: data
    });

    ajax_request.success(function(response){
      if (response == "Please enter a valid title."){
        that.append(response);
      }
      else  {
        that.parent().html(response);
      }
    });
  });


});
