function createProjectTree(projectName) {

	
	$("#treeViewDiv")
			.jstree(
					{
						'core' : {
							'type' : 'post',
							'data' : {
								'url' : function(node) {
									return node.id === '#' ? 'getProjectRoot'
											: 'getProjectChilds';
								},
								'contentType' : 'application/json; charset=utf-8',
								'data' : function(node) {
									if (node.id === '#') {
										return {
											'projectName' : projectName
										};
									} else {
										return {
											'id' : node.id
										};
									}
								}
							},
							'check_callback' : function(o, n, p, i, m) {
								/*
								 * if (m && m.dnd && m.pos !== 'i') { return
								 * false; }
								 */
								if (o === "move_node" || o === "copy_node") {
									if (this.get_node(n).parent === this
											.get_node(p).id) {
										return false;
									}
								}
								return true;
							},
							"themes" : {
								"theme" : "classic",
								"dots" : true,
								"icons" : true
							}
						},
						'contextmenu' : {
							'items' : function(node) {
								var tmp = $.jstree.defaults.contextmenu.items();
								delete tmp.ccp.submenu;
								delete tmp.ccp.action;
								tmp.ccp.label = "Lock/Unlock";
								tmp.ccp.submenu = {
									"lock_file" : {
										"separator_after" : true,
										"label" : "Lock",
										"action" : function(data) {
											var inst = $.jstree
													.reference(data.reference), obj = inst
													.get_node(data.reference);
											var isLocked = $('#'+obj.id+' > a').attr("locked");
											if(isLocked == "false"){
												  $
													.ajax({
														type : "GET",
														url : "lockFile?&id="
																+ obj.id,
														contentType : "application/json; charset=utf-8",
														dataType : "json",
														success : function(d) {
														if(!d.successMsg){
															alert(d.successMsg);
														}
													$('#'+obj.id+' > a').attr("locked", true);
													$('#'+obj.id+' > a').attr("lockedBy", d.lockedBy);
													$("#treeViewDiv").jstree(true).set_icon(obj.id, "resources/images/lockedFile.png");
											},
													error : function(xhr,
															status, error) {
														alert('error');

													}
												});
											}else{
												alert("the file is already locked");
											}
											
										}
									},
									"unlock_file" : {
										"separator_after" : true,
										"label" : "Unlock",
										"action" : function(data) {
											var inst = $.jstree
													.reference(data.reference), obj = inst
													.get_node(data.reference);
											var isLocked = $('#'+obj.id+' > a').attr("locked");
											var lockedBy =  $('#'+obj.id+' > a').attr("lockedBy");
											var currentUserName = $("#currentUserName").val();
												if(isLocked == "true"){
													if(currentUserName == lockedBy){
														$
														.ajax({
															type : "GET",
															url : "unlockFile?&id="
																	+ obj.id,
															contentType : "application/json; charset=utf-8",
															dataType : "json",
															success : function(d) {
																$('#'+obj.id+' > a').attr("locked", false);
																$('#'+obj.id+' > a').attr("lockedBy", "");
																$("#treeViewDiv").jstree(true).set_icon(obj.id, "resources/images/file.png");
															},
															error : function(xhr,
																	status, error) {
														
															}
														});
													}else{
														alert("file is locked by "+ lockedBy +" , you cannot unlock it. ");
													}
													
												}else{
													alert("file is already unlocked");
												}
										
										}
									}/*,
									"History" : {
										"separator_after" : true,
										"label" : "History",
										"action" :function(data){
											$('#editorDiv').hide();
											var inst = $.jstree
											.reference(data.reference), obj = inst
											.get_node(data.reference);
											$.get('redirectrollback', {
												'id' : obj.id
											}).done(function(d) {
												showRollbackDiv(d);
											}).fail(function() {
												data.instance.refresh();
											});
										}
									}
									*/
									}
								
								delete tmp.create.action;
								tmp.create.label = "New";
								tmp.create.submenu = {
									"create_folder" : {
										"separator_after" : true,
										"label" : "Folder",
										"action" : function(data) {
											var inst = $.jstree
													.reference(data.reference), obj = inst
													.get_node(data.reference);
											inst
													.create_node(
															obj,
															{
																type : "default",
																icon : "resources/images/folder.png"
															},
															"last",
															function(new_node) {
																setTimeout(
																		function() {
																			inst
																					.edit(new_node);
																		}, 1000);
															});
										}
									},
									"create_file" : {
										"label" : "File",
										"action" : function(data) {
											var inst = $.jstree
													.reference(data.reference), obj = inst
													.get_node(data.reference);
											inst
													.create_node(
															obj,
															{
																type : "file",
																icon : "resources/images/file.png"
															},
															"last",
															function(new_node) {
																setTimeout(
																		function() {
																			inst
																					.edit(new_node);
																		}, 1000);
															});
										}
									}
								};
								if (this.get_type(node) === "file") {
									delete tmp.create.action;
									delete tmp.create.submenu;
									tmp.create.label = "History",
									tmp.create.action = function(data){
										var inst = $.jstree
										.reference(data.reference), obj = inst
										.get_node(data.reference);
										$('#editorDiv').hide();
										
										var fileName=obj.text;
										$('#fileNm').html(fileName);
										var inst = $.jstree
										.reference(data.reference), obj = inst
										.get_node(data.reference);
										$.get('redirectrollback', {
											'id' : obj.id
										}).done(function(d) {
											showRollbackDiv(d);
										}).fail(function() {
											data.instance.refresh();
										});
									}
									
									
								}
								if (this.get_type(node) === "default") {
									delete tmp.remove;
									delete tmp.ccp;
								}
								return tmp;
							}
						},
						'types' : {
							'default' : {
								'icon' : 'folder'
							},
							'file' : {
								'valid_children' : [],
								'icon' : 'file'
							}
						},
						'unique' : {
							'duplicate' : function(name, counter) {
								return name + ' ' + counter;
							}
						},
						'plugins' : [ 'themes', 'state', 'dnd', 'sort',
								'types', 'contextmenu', 'unique' ]
					}).on('delete_node.jstree', function(e, data) {
				$.get('deleteFile', {
					'id' : data.node.id
				}).fail(function() {
					data.instance.refresh();
				});
			}).on('create_node.jstree', function(e, data) {
				$.get('createFile', {
					'type' : data.node.type,
					'id' : data.node.parent,
					'text' : data.node.text
				}).done(function(d) {
					data.instance.set_id(data.node, d.id);
				}).fail(function() {
					data.instance.refresh();
				});
			}).on('rename_node.jstree', function(e, data) {
				$.get('renameFile', {
					'id' : data.node.id,
					'text' : data.text
				}).done(function(d) {
					data.instance.set_id(data.node, d.id);
				}).fail(function() {
					data.instance.refresh();
				});
			});
}

function showRollbackDiv(data)
{
	 var tableData='<tr><th>Select</th><th>Version Name</th><th>Modified Date</th><th>Modified By</th><th>Comment</th></tr>';
	 $.each($.parseJSON(data), function(idx, obj) {
		 if(obj.currentVersion==='true')
			 {
		 tableData+='<tr><td><input type="radio" value="'+obj.versionName+'" disabled name="vscompare"></td>';
			 }
		 else
			 {
			 tableData+='<tr><td><input type="radio" class="radioBtn" value="'+obj.versionName+'" name="vscompare"></td>'; 
			 }
		 tableData+='<td>'+obj.versionName+'</td><td>'+obj.modifiedDate+'</td><td>'+obj.modifiedBy+'</td><td>'+obj.comment+'</td></tr>';
		});
	 $("#editorDiv").hide();
	 $("#versionsTable").html(tableData);
	 $("#historyDiv").show(); 
}