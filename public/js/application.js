$(document).ready(function() {
  $("#login-button").on("submit", function(event){
    event.preventDefault();
    var url = $(this).attr("action");
    var ajax_request = $.ajax({
                                url: url,
                                method: "GET"

    });
    ajax_request.success(function(response){
      $("#login-button").html(response);
    });
  });

  $(document).on("submit", "#login-button", function(event){
    event.preventDefault();
    var data = $("#login").serialize
    // var url =
  });
});
