<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />
<sec:authorize access="isAuthenticated()">
	<!DOCTYPE html>
	<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="description" content="">
<meta name="author" content="">
<title>Source Control System</title>

<!-- Bootstrap -->
<!--<script src="js/pace.js"></script>-->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/css/bootstrap-select.css" rel="stylesheet">
<link href="resources/css/scs.css" rel="stylesheet">
<link href="resources/css/parsley.css" rel="stylesheet">
<link href="resources/css/theme.css" rel="stylesheet">
<link href="resources/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/css/morris.css" rel="stylesheet">
<link href="resources/css/sb-admin-2.css" rel="stylesheet">
<link href="resources/css/shop-homepage.css" rel="stylesheet">
<link href="resources/css/timeline.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/style.min.css" />
<link rel="stylesheet" href="resources/css/editor.css" />
<link rel="stylesheet" href="resources/css/jquery-ui.css" />

<style>
.parsley-required {
	margin-top: 0px;
}

.bootstrap-select {
	width: 400px;
}

.ui-widget-header, .ui-state-default, ui-button {
	background: #b9cd6d;
	border: 1px solid #b9cd6d;
	color: #FFFFFF;
	font-weight: bold;
}
#versionsTable
{
	width:100%;
	
}
#versionsTable th
{
	font-size: 15px;
    color: rgba(0, 150, 136, 0.84);
     text-align: center;
}
#versionsTable tr
{
	font-size:12px;
	 text-align: center;
}
</style>


<!--<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:700,400|Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>-->
<link href="resources/css/theme-loading-bar.css" rel="stylesheet" />
<link href="resources/css/shop-homepage.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div class="container" id="container"
		style="display: block; padding-top: 30px;">
		<header>
			<!-- Main comapny header -->
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand top-navbar-brand" href="#"><img
							style="margin-top: -13px; max-width: 17%;"
							src="resources/images/icons/SCS-Logo.jpg" /> Source Control
							System <br />
						<p
								style="font-size: 20px; margin-left: 111px; margin-top: -35px; font: italic; color: #428bca;">
								<i>One step solution for your Source management</i>
							</p></a>
					</div>
					<ul class="nav navbar-nav navbar-right bigger-130 hidden-xs">
						<li><a href="#"><i class="logo"></i></a> <img
							src="resources/images/logo.png"
							style="margin-top: -15px; border-radius: 20px; opacity: .7; width: 50px;" /></li>

					</ul>
				</div>
			</nav>
		</header>

		<div class="container">
			<input type="hidden" id="currentUserName" value='${user.username}' />


			<div class="col-lg-12" role="navigation"
				style="margin-bottom: 0; background-color: #f8f8f8; border-color: #e7e7e7;">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand"
						href="${req.requestURL}/SCS-Assignment/welcome"><img
						src="resources/images/home.png" /></a> <span class="navbar-brand"
						style="color: #479AC3; font-size: 15px;">Welcome&nbsp;&nbsp;${user.username}</span>
				</div>
				<!-- /.navbar-header -->

				<ul class="nav navbar-top-links navbar-right">

					<!-- /.dropdown -->

					<!-- /.dropdown -->

					<!-- /.dropdown -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="${req.requestURL}/SCS-Assignment/userProfile"><i
									class="fa fa-user fa-fw"></i> User Profile</a></li>
							<li><a href="${req.requestURL}/SCS-Assignment/change"><i
									class="fa fa-gear fa-fw"></i> Change Password</a></li>
							<li>
								<!-- <a onclick="return cloneProject()"><i class="fa fa-gear fa-fw"></i> Clone Project</a> -->
								<a onclick="return cloneProject()"><i
									class="fa fa-gear fa-fw"></i> Clone Project</a>
								<form id="cloneForm" method="post" name="cloneForm"
									action="/SCS-Assignment/cloneProject">
									<input type="hidden" id="url" value="default" name="url">

								</form>
							</li>
							<li class="divider"></li>
							<li><a href="${req.requestURL}/SCS-Assignment/logout"><i
									class="fa fa-sign-out fa-fw"></i> Logout</a></li>
						</ul> <!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
				</ul>
				<!-- /.navbar-top-links -->


				<!-- /.navbar-static-side -->
			</div>






			<div class="row" style="margin-top: 10px;">
				<center>
					<div class="col-lg-12">
						<%--  <form> --%>
						<div class="form-group" style="padding-top: 10px;">
							<!--  <select  class="col-lg-9 selectpicker" data-live-search="true" data-live-search-style="begins" title="Please select a repository URL to access ..." style="width:400px;">
						<option>URL 1</option>
						<option>URL 2</option>
						<option>URL 3</option>
						<option>URl 4</option>
						<option>URL 4</option>
					  </select> -->
							<h>please select a project : </h>
							<select id="projectUrl">

							</select>
						</div>
						<%-- </form> --%>
					</div>
				</center>
				<div class="row"
					style="border: 1px solid #BCBCBC; max-height: 500px; hight: auto">
					<div id="treeViewDiv" display: none; class="col-lg-3"
						style="display: none; overflow-y: scroll; float: left; overflow-x: scroll; border-right: 1px solid #BCBCBC; height: 400px; border-top: 1px solid #BCBCBC;">


					</div>
					<div id="editorDiv" class="col-lg-9"
						style="display: none; overflow-y: scroll; float: left; overflow-x: scroll; border: 1px solid #BCBCBC; height: 400px;">

						<div id="content">
							<textarea id="editor" name="editor" style="display: none"></textarea>
							<div id="dialog-modal" title="Provide comments"
								style="display: none; width: 350px;">
								<div>
									<label style="float: left;">Comments :</label><input
										style="float: right;" type="text" placeholder="Comments"
										id="commentbox">
								</div>

							</div>
							<div id="dialog-modal-msg" title=""
								style="display: none; width: 350px;">
								<div>
									<label style="float: left;" id="statusmsg"></label>
								</div>

							</div>
							<div id="hiddenfields">
								<input type="hidden" id="filename"> <input
									type="hidden" id="parentid">
							</div>
						</div>
						<div class="change passwordform">
							<div class="col-lg-12 " style="padding-top: 40px;" id="commitbtn"
								style="display:none;">
								<div class="col-lg-6">
									<button type="submit" tabindex='11' id="red"
										class="btn btn-lg btn-primary registerBtn"
										style="margin-right: -40px;" onclick="javascript:commit();">Commit</button>
								</div>
								<div class="col-lg-6">
									<button type="reset" tabindex='12'
										class="btn btn-lg btn-primary cancelBtn"
										style="margin-left: 40px;"javascript:cancel();">Cancel</button>
								</div>
							</div>
						</div>


					</div>

					<div id="historyDiv" class="col-lg-9"
						style="display: none; overflow-y: scroll; float: left; overflow-x: scroll; border: 1px solid #BCBCBC; height: 400px;">
						 <div class="col-lg-12" style="width: 105%;margin-left: -20px;">
							<div class="formhead">
								
									<h1>History of <span id="fileNm"></span></h1>
								
							</div>
						</div>
						
						<div id="content">
							<table id="versionsTable" border="1" style="border:"1px solid rgba(23, 58, 62, 0.82);">

							</table>

							<div class="col-lg-12 " style="padding-top: 40px;">
								<table>
									<tr>
										<td><button type="button" id="rollbackBtn"
												class="btn btn-lg btn-primary registerBtn">Rollback</button></td>


										<td><button type="button" id="compareBtn"
												class="btn btn-lg btn-primary registerBtn"
												onclick="javascript:compare();">Compare</button></td>
										<td>
										<button type="reset" tabindex='12'
								class="btn btn-lg btn-primary cancelBtn"
								style="margin-left: 40px;onclick="javascript:cancel();">Cancel</button></td>
									
										<td></td>
									</tr>
								</table>

							</div>
						</div>
						<div class="col-lg-6">
							
						</div>
					</div>
				</div>


			</div>

			<div class="col-lg-12" id="compareDialog" style="margin-top: 100px;">
				<div id="dialog-modal-compare" title=""
					style="display: none; width: 100%; margin-top: 0px;">
					<table width="100%">
						<tbody>
							<tr>
								<td width="50%">
									<h3 id="version1"></h3> <textarea id="text1"
										style="width: 100%" rows="10"></textarea>
								</td>
								<td width="50%">
									<h3 id="version2"></h3> <textarea id="text2"
										style="width: 100%" rows="10"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="col-lg-12" id="compareresult"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- Row Div-->

	</div>
	<!-- container Div-->




	<footer>
		<nav class="navbar navbar-default navbar-fixed-bottom"
			role="navigation" style="min-height: 5%; height: 6%;">
			<div class="container text-center">
				<div class="footer-content">
					Copyright @ Persistent System Ltd. All rights reserved. </a>
				</div>
			</div>
			<!-- /.container-fluid -->
		</nav>
	</footer>
	</div>

	<script src="resources/js/jquery.min.js"></script>

	<script src="resources/js/bootstrap.min.js"></script>
	<!--<script src="js/jquery.backstretch.min.js"></script>-->
	<script src="resources/js/parsley.js"></script>

	<script src="resources/js/bootstrap-select.min.js"></script>
	<script src="resources/js/metisMenu.js"></script>
	<script src="resources/js/raphael.js"></script>

	<script src="resources/js/sb-admin-2.js"></script>

	<script src="resources/js/user.js"></script>
	<!-- <script src="resources/js/dist/libs/jquery.js">
        </script> -->
	<script src="resources/js/jstree.min.js">
        </script>
	<script src="resources/js/repositoryTree.js"></script>
	<script src="resources/js/ckeditor.js"></script>


	<script src="resources/js/jquery-ui.js"></script>

	<script src="resources/js/diff_match_patch.js"></script>
	<!--<script>
		Pace.on('hide', function(){
		  $("#container").fadeIn('1000');
		  $.backstretch([
				"images/image2.png",
				
			]);
		});
		
	</script>-->
	<!--<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-53918379-1', 'auto');
	  ga('send', 'pageview');

	</script>-->
	<script>
	  $('#loginform').parsley();
	  function submit()
	  {
	   $('#loginform').submit();
	  }
	</script>
	<script>
  $(document).ready(function () {
	/*  editor = CKEDITOR.inline( 'editable', {
		    removePlugins: 'toolbar'
		} ); */
	  
	  $(function() {
          $( "#dialog-modal" ).dialog({
             autoOpen: false, 
             width: 350,
             modal: true,
             buttons: {
                OK: function() {
                	
                	commitFile();
                },
         		Cancel: function() {$(this).dialog("close");
        		  }
             },
             title: "",
             position: {
                my: "center",
                at: "center"
             }
          });
          
         $('.ui-dialog-buttonset').css('float','left');
         $('.ui-dialog-buttonset').css('margin-left','100px');
         
       });
	  
	  $(function() {
			  $( "#dialog-modal-msg" ).dialog({
		          autoOpen: false, 
		          width: 350,
		          modal: true,
		          buttons: {
		            
		      		OK: function() {$(this).dialog("close");
		     		  }
		          },
		          title: "",
		          position: {
		             my: "center",
		             at: "center"
		          }
		       });
		       
		     
		      
		    });
  		
	  $(function() {
          $( "#dialog-modal-compare" ).dialog({
             autoOpen: false, 
             width: 800,
             height:500,
             modal: true,
             buttons: {
                OK: function() {
                	$(this).dialog("close");
                }
             },
             title: "",
             position: {
                my: "center",
                at: "center"
             }
          });
          
         $('.ui-dialog-buttonset').css('float','left');
         $('.ui-dialog-buttonset').css('margin-left','100px');
         
       });
	  
	  
    var mySelect = $('#first-disabled2');

    $('#special').on('click', function () {
      mySelect.find('option:selected').prop('disabled', true);
      mySelect.selectpicker('refresh');
    });

    $('#special2').on('click', function () {
      mySelect.find('option:disabled').prop('disabled', false);
      mySelect.selectpicker('refresh');
    });

    $('#basic2').selectpicker({
      liveSearch: true,
      maxOptions: 1
    });
	
	$('.bootstrap-select').css('width','400px');
	$('#rollbackBtn').on('click',function(){
		rollback();
	});
	
	$('#compareBtn').on('click',function(){
		compare();
	});
	
	$('.cancelBtn').on('click',function(){
		$("#historyDiv").hide();
		$("#editorDiv").hide();
	});
  });
  
  
  $('#treeViewDiv').on("select_node.jstree", function(e, data) {
	 // var n = $.tree.focused().get_node('li:eq(0)')
	 var selectedNode= $('#treeViewDiv').jstree(true).get_selected('full',true);
		selectedNode = selectedNode[0];
		$("#historyDiv").hide();
		/* var id = selectedNode.id;
		var text = selectedNode.text;
		var parent = selectedNode.parent; */
		$('#editorDiv').show();
	   $('#filename').val(selectedNode.text);
		 $('#parentid').val(selectedNode.parent);
		if (selectedNode.type == 'file') {
			
			 var filename=$('#filename').val();
			 var parentid=$('#parentid').val();
			
			 
			 //alert(filecontent+":"+filename+":"+parentid+":"+comments);
			 
			 $.ajax({
					url : "getContent" ,
					type: "POST",
					data : {
						
						"filename" :filename,
						"parentid":parentid
						
					},
					success: function(data, textStatus, jqXHR)
					{
					var contenttemp=data.filecontent;
					var content;
						if(contenttemp == null || contenttemp =='null')
							{
							
							content="";
							}
						else
							{
							content=contenttemp.replace(/\n/g, "<br />");
							}
						$("#content").show();
						//CKEDITOR.replace('editor');
						
						$(CKEDITOR.instances.editor.setData('<p>'+content+'</p>'));
						$('#commitbtn').show();
						
						console.log(data);
					},
					error: function (jqXHR, textStatus, errorThrown)
					{
						 $( "#dialog-modal-msg" ).dialog( "open" );
						 $('#statusmsg').html('Error occured.Please try again.');
						 $("#content").hide();
							$('#commitbtn').hide();
					}
				});
			$("#content").show();
			CKEDITOR.replace('editor');
			/* CKEDITOR.inline( editor, {
			    removePlugins: 'toolbar'
			} ); */
			
			
			
			//$('#commitbtn').show();
		} else {
			$("#content").hide();
			$('#commitbtn').hide();
		}
	});
	
	function cloneProject(){
		document.getElementById('url').value=$("#url").text();
		document.getElementById("cloneForm").submit();
	  
	  
	  
  }
	
	function commit()
	  {
		
		 $( "#dialog-modal" ).dialog( "open" );
		
		 // alert(fileContent);
	  }
	function cancel()
	  {
		
		 $( "#dialog-modal" ).dialog( "close" );
		
		 // alert(fileContent);
	  }
	function commitFile()
	{
		 $( "#dialog-modal" ).dialog( "close" );
		
		 var filecontent=$(CKEDITOR.instances.editor.getData()).text().replace("<br />", "\n", "g");
		
		 var filename=$('#filename').val();
		 var parentid=$('#parentid').val();
		 var comments=$('#commentbox').val();
		 
		 //alert(filecontent+":"+filename+":"+parentid+":"+comments);
		 
		 $.ajax({
				url : "saveFile" ,
				type: "POST",
				data : {
					"filecontent" : filecontent,
					"filename" :filename,
					"parentid":parentid,
					"comments":comments
				},
				success: function(data, textStatus, jqXHR)
				{
					 $( "#dialog-modal-msg" ).dialog( "open" );
					 $('#statusmsg').html(data.msg);
					 $('#commentbox').val("");
					console.log(data);
				},
				error: function (jqXHR, textStatus, errorThrown)
				{
					 $( "#dialog-modal-msg" ).dialog( "open" );
					 $('#statusmsg').html('Error occured.Please try again.');
					 $('#commentbox').val("");
				}
			});
		 function onClickToolbarButton() {
			     var bar = document.getElementById("cke_1_top");
			     if(bar.style.display == "none"){
			         bar.style.display = "block";
			     }else{
			         bar.style.display = "none";
			     }

			     //resize web page
			     //onresize();
			 }
		  
  }
	
	function rollback()
	  {
		  var selectedNode= $('#treeViewDiv').jstree(true).get_selected('full',true);
			selectedNode = selectedNode[0];
			var isLocked = $('#'+selectedNode.id+' > a').attr("locked");
			var lockedBy=$('#'+selectedNode.id+' > a').attr("lockedBy");
			var currentUser=$("#currentUserName").val();
			var selectedVersion=$("input[type='radio'].radioBtn:checked").val();
			if(isLocked=='false')
			{
				$.ajax({
					url : "rollback" ,
					type: "POST",
					data : {
						'filename' : selectedNode.text,
						'versionno' : selectedVersion
					},
					success: function(data, textStatus, jqXHR)
					{
						
						$("#historyDiv").hide();
						$("#editorDiv").show();
						 $( "#dialog-modal-msg" ).dialog( "open" );
						 $('#statusmsg').html(data.isSuccess);
						 
						 
						 var contenttemp=data.filecontent;
							var content;
								if(contenttemp == null || contenttemp =='null')
									{
									
									content="";
									}
								else
									{
									content=contenttemp.replace(/\n/g, "<br />");
									}
								$("#content").show();
								//CKEDITOR.replace('editor');
								
								$(CKEDITOR.instances.editor.setData('<p>'+content+'</p>'));
								$('#commitbtn').show();
								
								console.log(data);
						 
						 
						console.log(data.filecontent+" Status:"+data.isSuccess);
					},
					error: function (jqXHR, textStatus, errorThrown)
					{
						/*  $( "#dialog-modal-msg" ).dialog( "open" );
						 $('#statusmsg').html('Error occured.Please try again.'); */
						 $( "#dialog-modal-msg" ).dialog( "open" );
						 $('#statusmsg').html('Error occured.Please try again.');
						 $("#content").hide();
							$('#commitbtn').hide();
					}
				});
			
			}
			else 
			{
				if(currentUser==lockedBy)
					{
					alert("Locked file can't be rollbacked");
					}
				else
				   {
					alert("File is locked by  "+lockedBy+" ,  it can't be rollbacked");
				   }
			}
	  }
	function compare()
	{
		
		 var selectedNode= $('#treeViewDiv').jstree(true).get_selected('full',true);
			selectedNode = selectedNode[0];
			var fileName=selectedNode.text;
			var selectedVersion=$("input[type='radio'].radioBtn:checked").val();
			var currentVersion=$("input:disabled").val();
			var parentNodeId=selectedNode.parent;
			
			 $.ajax({
					url : "compare" ,
					type: "POST",
					data : {
						'fileName' : selectedNode.text,
						'currentVersion' : currentVersion,
						'selectedVersion':selectedVersion,
						'parentNodeId':parentNodeId
					},
					success: function(data, textStatus, jqXHR)
					{
						var text1=data.versionid2;//old
						var text2=data.versionid1;//new
						$('#version1').html('Version:'+data.id2version);
						$('#version2').html('Version:'+data.id1version);
						launch(text1,text2);
						console.log(data.versionid1+" new:"+data.versionid2+" Status:"+data.isSuccess);
					},
					error: function (jqXHR, textStatus, errorThrown)
					{
						/*  $( "#dialog-modal-msg" ).dialog( "open" );
						 $('#statusmsg').html('Error occured.Please try again.'); */
					}
				});
			
			/* $.post('compare', {
				'fileName' : selectedNode.text,
				'currentVersion' : currentVersion,
				'selectedVersion':selectedVersion,
				'parentNodeId':parentNodeId
			}).done(function(d) {
				
				//Data Returns here
			}).fail(function() {
				data.instance.refresh();
			}); */
	}
</script>
	<script>

	var dmp = new diff_match_patch();
	
	function launch(text1,text2) {
		$('#text1').val(text1);
		$('#text2').val(text2);
	//  var text1 = document.getElementById('text1').value;
	 // var text2 = document.getElementById('text2').value;
	  //dmp.Diff_Timeout = parseFloat(document.getElementById('timeout').value);
	 // dmp.Diff_EditCost = parseFloat(document.getElementById('editcost').value);
	
	 // var ms_start = (new Date()).getTime();
	 if(text1 == null || text1 == 'null')
		 {
		 text1=" ";
		 }
	 if(text2 == null || text2 == 'null')
	 {
	 text2=" ";
	 }
	  var d = dmp.diff_main(text1, text2);
	  var ms_end = (new Date()).getTime();
	
	/*   if (document.getElementById('semantic').checked) {
	    dmp.diff_cleanupSemantic(d);
	  }
	  if (document.getElementById('efficiency').checked) {
	    dmp.diff_cleanupEfficiency(d);
	  } */
	  var ds = dmp.diff_prettyHtml(d);
	  $('#compareresult').html(ds) ;
	 
	  $( "#dialog-modal-compare" ).dialog( "open" );
	}
	
</script>
</body>
	</html>
</sec:authorize>
