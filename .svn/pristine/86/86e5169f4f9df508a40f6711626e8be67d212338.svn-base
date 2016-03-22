$()
		.ready(
				function() {
					
					
					// ajax call to fetch project list and populate on add user
					// screen #projectUrl
					$
							.ajax({
								type : "GET",
								url : "getAllProjectNamesLinkedToUser",
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
									getLockedFileListbyProjectName(selectedProjectName);
								}
								$("#lockedFilesTableDiv").hide();
							});
					
					
					
					function getLockedFileListbyProjectName(selectedProjectName) {
					
					$
							.ajax({

								type : "GET",
								url : "getAllLockedFilesOfProject?projectName="
									+ selectedProjectName,								
								contentType : "application/json; charset=utf-8",
								dataType : "json",
								success : function(data) {

									if (data != 0) {
										$('#lockedFilesTable tbody > tr')
												.remove();
										//alert("in data not zero");
										$("#lockedFilesTableDiv").show();
										$
												.each(
														data,
														function(index, item) {
															var fileName =item.fileName;
															var buttonValue = "Unlock";
															var buttonId = item.fileId;
//															var statusId = item.userName
//																	+ "_status";
															
															$('#lockedFilesTable')
																	.append(
																			'<tr id=row'+buttonId+'><td>'
																					+ item.fileName
																					+ '<\/td><td id='
																					+ item.fileId
																					+ '>'
																					+ item.lockedByUserName
																					+ '<\/td><td><button id='
																					+ buttonId
																					+
																					' class=unlock'+buttonId
																					+ '>'
																					+ buttonValue
																					+ '</button><\/td></tr>');
															
															
															$('.unlock'+buttonId).click({
																
																id : $(this).attr('id'),
																name : fileName
															
															},
															function(event) {
																var id= $(this).attr('id');
																unlockSelectedFile(id,event.data.name);

															});

											function unlockSelectedFile(fileId,fileName) {
												//alert("Clicked : "+ fileId + " fileName : "+ fileName);
												
												
												$.ajax({
															async : true,
															type : "GET",
															url : "unlockSelectedFile",
															data:{
																'fileId':fileId																					
															},
															contentType : "text/plain",
															dataType : "text",
															success : function(data) {
															//	alert("data="+data);
																console.log(data);
																if (data == 'Success') {
																	alert("File "+ fileName+ " is successfully unlocked.");
																	
																	$("#"+ fileId).text("Unlocked");
																	$('#row'+fileId).hide();
																	var rowCount = $('#lockedFilesTable tr').length;
																	if(rowCount==2)
																		{
																		$('#lockedFilesTable').hide();
																		
																		}
																} else {
																	alert("some error has occured. Please try again");
																}
															},
															error: function(xhr, error) {
																  var err = xhr.responseText;//eval("(" + xhr.responseText + ")");
																  alert("status="+status)
																  alert("error="+err);
																alert("readyState: "+xhr.readyState+"\nstatus: "+xhr.status);
															    alert("responseText: "+xhr.responseText);
															    alert("error="+error);
															}
														});
															
											}

														});
									} else {
										alert("Locked files are not present in this project");
										$("#lockedFilesTable").hide();
									}
									
									
									

								},

								error : function(xhr, status, error) {
									console.log(error);
								}

							});
					
				}

				});


