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

					$("#projectUrl")
							.change(
									function() {
										if ($("#projectUrl").val() != -1) {
											var selectedProjectName = $(
													"#projectUrl option:selected")
													.text();
											getUserDetailsbyProjectName(selectedProjectName);
										}
										$("#userDetailTableDiv").hide();
									});

					function getUserDetailsbyProjectName(selectedProjectName) {
						$
								.ajax({
									async : true,
									type : "GET",
									url : "getAllUsersLinkedToProject?projectName="
											+ selectedProjectName,
									contentType : "application/json; charset=utf-8",
									dataType : "json",
									success : function(data) {
										if (data != null) {
											$('#userDetailTable tbody > tr')
													.remove();
											$("#userDetailTableDiv").show();
											$
													.each(
															data,
															function(index,
																	item) {
																var status = (item.active ? "Active"
																		: "De-Active");
																var buttonValue = (item.active ? "De-Activate"
																		: "Activate");
																var buttonId = item.userName
																		+ "_statusButton";
																var statusId = item.userName
																		+ "_status";
																$(
																		'#userDetailTable')
																		.append(
																				'<tr><td>'
																						+ item.userName
																						+ '<\/td><td id='
																						+ statusId
																						+ '>'
																						+ status
																						+ '<\/td><td><button id='
																						+ buttonId
																						+ '>'
																						+ buttonValue
																						+ '</button><\/td></tr>');
																$(
																		'#'
																				+ buttonId)
																		.click(
																				{
																					id : buttonId,
																					statusId : statusId,
																					user : item.userName,
																					isActive : item.active,
																					projectName : selectedProjectName
																				},
																				function(
																						event) {
																					if (event.data.isActive == true) {
																						deActivateUser(
																								event.data.id,
																								event.data.statusId,
																								event.data.user,
																								event.data.projectName);
																					} else {
																						activateUser(
																								event.data.id,
																								event.data.statusId,
																								event.data.user,
																								event.data.projectName);
																					}
																				});
															});
										} else {
											$("#userDetailTableDiv").hide();
										}

									},
									error : function(xhr, status, error) {
										console.log(error);
									}

								});
					}

					function deActivateUser(buttonId, statusId, user,
							projectName) {
						$
								.ajax({
									async : true,
									type : "GET",
									url : "deActivateUser?userName=" + user
											+ "&projectName=" + projectName,
									contentType : "application/json; charset=utf-8",
									dataType : "json",
									success : function(data) {
										if (data.success == 'Y') {
											alert("user " + user
													+ " is deactivated for "
													+ projectName + " project");
											$("#" + buttonId).text("Activate");
											$("#" + statusId).text("De-Active");
											$('#' + buttonId).off("click");
											$('#' + buttonId)
													.click(
															{
																id : buttonId,
																statusId : statusId,
																user : user,
																projectName : projectName
															},
															function(event) {
																activateUser(
																		event.data.id,
																		event.data.statusId,
																		event.data.user,
																		event.data.projectName);
															});
										} else {
											alert("some error has occured. Please try again");
										}
									}
								});
					}

					function activateUser(buttonId, statusId, user, projectName) {
						$
								.ajax({
									async : true,
									type : "GET",
									url : "activateUser?userName=" + user
											+ "&projectName=" + projectName,
									contentType : "application/json; charset=utf-8",
									dataType : "json",
									success : function(data) {
										if (data.success == 'Y') {
											alert("user " + user
													+ " is activated for "
													+ projectName + " project");
											$("#" + buttonId).text(
													"De-Activate");
											$("#" + statusId).text("Active");
											$('#' + buttonId).off("click");
											$('#' + buttonId)
													.click(
															{
																id : buttonId,
																statusId : statusId,
																user : user,
																projectName : projectName
															},
															function(event) {
																deActivateUser(
																		event.data.id,
																		event.data.statusId,
																		event.data.user,
																		event.data.projectName);
															});
										} else {
											alert("some error has occured. Please try again");
										}
									}
								});
					}
				});