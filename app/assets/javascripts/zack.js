$(document).ready(function(){
		$("#table_tournament,#table_venue,#table_group,#table_player").DataTable({
			paging: false,
			info: false
		});

		$(".delete_tournament").click(function() {
    swal({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result) {
            $.ajax({
                type: "POST",
                url: "/destroy_tournament",
                data: {
                    id: this.id
                },
                success: (response) => {
                    if (response.status == "success") {
                        swal(
                            'Wohooo!',
                            response.message,
                            'success'
                        )

                        $(this).parent().fadeOut();
                    } else {
                        swal(
                            'Oops...',
                            response.message,
                            'error'
                        )
                    }
                }
            });
                       
        }
    })
});

		$(".tournaments").editable({
			url: "/update_tournament",
			type: 'post',
			params: function(params){
                var tour_id = $(this).attr("tour_id");
                params.id = tour_id;
                return params;                
			},
	    success: (response) => {
	        if (response.status == "success") {
	            swal(
	                'Wohooo!',
	                response.message,
	                'success'
	            )

	        } else {
	            swal(
	                'Oops...',
	                response.message,
	                'error'
	            )
	        }
	    }
		})
})