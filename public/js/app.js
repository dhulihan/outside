$(function() {
	// disable form
	$("form").submit(function() {
		return false;
	});

	function debug(str){
		console.log(str)
	}

	$(document).on("click", "#check", function() {
		var url = "/api/v1/zipcode"; 
		var zipcode = $("input[name='zipcode']").val();

		$.ajax({
			url: url,
			type: "GET",
			data: {
				zipcode: zipcode
			},
			dataType: "json", 
			beforeSend: function ( xhr ) {
				debug("beforeSend")
				debug("zipcode: " + zipcode)
				$("a .fa").addClass("fa-spin fa-spinner")
			},
			success: function(data, status, xhr){
				debug("success:")
				debug(data)
				$("#results").html(data.message)
			},
			error: function(xhr, status, error){
				var resp = $.parseJSON(xhr.responseText)
				$("#results").html(resp.error)
				$("#results").addClass("text-danger")
			},
			// Called on success and error
			complete: function(xhr, status){
				$("a .fa").removeClass("fa-spin fa-spinner")
			}
		});			
	});
});	