$(function() {
	$(document).on("click", "#check", function() {
		$(this).find(".fa").addClass("fa-spin")
		$("#results").html("NOPE");
	});
});	