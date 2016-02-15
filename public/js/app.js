$(function() {
	// disable form
	$("form").submit(function() {
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
				$("#check .fa").addClass("fa-spin fa-spinner")
			},
			success: function(data, status, xhr){
				debug("success:")
				$("#results").removeClass("text-danger")
				$("#summary").html(data.summary)
				switch (data.summary) {
				  case "YES":
					$("#summary").addClass("text-success")
				    break;
				  case "MAYBE":
					$("#summary").addClass("text-warning")
				    break;
				  case "NO":
					$("#summary").addClass("text-danger")
				    break;
				}				
				$("#message").html(data.message)
				// $("#more-info-btn").show()
			},
			error: function(xhr, status, error){
				switch (xhr.status) {
				  case 500:
				    console.log("Got 500");
				    break;
				  case 400:
				    console.log("Got 400");
				    break;
				}				
				debug(xhr)
				$("#results").html(xhr.responseJSON.error)
				$("#results").addClass("text-danger")
			},
			// Called on success and error
			complete: function(xhr, status){
				$("#check .fa").removeClass("fa-spin fa-spinner")
			}
		});

		// don't do DOM submit
		return false;		
	});

	function debug(str){
		console.log(str)
	}

	$(document).on("click", "#check", function() {
		$("form").submit();		
	});

	$(document).on("click", "#more-info-btn", function() {
		$("#more-info").toggle();		
	});	
});	