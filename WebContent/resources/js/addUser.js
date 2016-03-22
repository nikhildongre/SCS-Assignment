$()
		.ready(
				function() {

					// ajax call to fetch project list and populate on add user
					// screen #projectUrl
					$
							.ajax({
								type : "GET",
								url : "getAllProjectNames",
								contentType : "application/json; charset=utf-8",
								dataType : "json",
								success : function(data) {
									$("#projectUrl").get(0).options.length = 0;
									$("#projectUrl").get(0).options[0] = new Option(
											"Select Project", "-1");

									$
											.each(
													data,
													function(index, item) {
														$("#projectUrl").get(0).options[$(
																"#projectUrl")
																.get(0).options.length] = new Option(
																item.project,
																item.project);
													});

								},

								error : function(xhr, status, error) {
									console.log(error);
								}
							});
				
					
						$('#addUserForm input[name="userRole"]').on('change', function() {
						var userRoleSelected = $("input[name='userRole']:checked").val();
						if(userRoleSelected == "pa"){
							$("#rootFolderDiv").show();
							$("#projectUrlDiV").hide();
						}else{
							$("#projectUrlDiV").show();
							$("#rootFolderDiv").hide();
						}
					});
				});