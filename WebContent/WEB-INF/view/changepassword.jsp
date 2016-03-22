<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />">
<link href="<c:url value="/resources/css/bootstrap-select.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/scs.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/parsley.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/theme.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/morris.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/sb-admin-2.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/shop-homepage.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/timeline.css" />" rel="stylesheet">

<style>
.parsley-required {
	margin-top: 0px;
}
</style>


<!--<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:700,400|Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>-->
<link href="<c:url value="/resources/css/theme-loading-bar.css" />" rel="stylesheet" />
<link href="<c:url value="/resources/css/shop-homepage.css" />" rel="stylesheet">

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
							style="margin-top: -13px; max-width: 23%;"
							src="<c:url value="/resources/images/icons/PSL_Logo.jpg"/>" /> Source Control System <br />
							<p style="font-size: 20px; margin-left: 135px; margin-top: -35px; font: italic; color: #428bca;">
								<i>One step solution for your Source management</i>
							</p></a>
					</div>
					<ul class="nav navbar-nav navbar-right bigger-130 hidden-xs">
						<li><a href="#"><i class="logo"></i></a> <img
							src="<c:url value="/resources/images/logo.png"/>"
							style="margin-top: -15px; border-radius: 20px; opacity: .7; width: 50px;" /></li>

					</ul>
				</div>
			</nav>
		</header>

		<div class="container">


			<div class="col-lg-12" role="navigation"
				style="margin-bottom: 0; background-color: #f8f8f8; border-color: #e7e7e7;">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					  <a class="navbar-brand" href="${req.requestURL}/SCS-Assignment/welcome"><img src="resources/images/home.png"/></a>
                     <span class="navbar-brand" style="color: #479AC3;  font-size: 15px;">Welcome&nbsp;&nbsp;${user.username}</span>	
                	</div>
				<!-- /.navbar-header -->

				<ul class="nav navbar-top-links navbar-right">

					
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							 <li><a href="${req.requestURL}/SCS-Assignment/userProfile"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="${req.requestURL}/SCS-Assignment/change"><i class="fa fa-gear fa-fw"></i> Change Password</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${req.requestURL}/SCS-Assignment/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li><!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
				</ul>
				<!-- /.navbar-top-links -->

				<!-- <div class="navbar-default sidebar" role="navigation"
					style="margin-top: 60px; margin-left: -15px;">
					<div class="sidebar-nav navbar-collapse">
						<ul class="nav" id="side-menu">

							<li><a href="index.html"><i
									class="fa fa-dashboard fa-fw"></i> Add user</a></li>
							<li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Charts<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="flot.html">Flot Charts</a>
                                </li>
                                <li>
                                    <a href="morris.html">Morris.js Charts</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level 
                        </li>
							<li><a href="tables.html"><i class="fa fa-table fa-fw"></i>
									User Details</a></li>



						</ul>
					</div>
					/.sidebar-collapse
				</div> -->
				<!-- /.navbar-static-side -->
			</div>


			<div class="row" style="margin-top: 10px;">
				<div class="col-lg-3" style="float: left;"></div>
				<div class="col-lg-9" style="margin-top: 10px;">
					<!--  -->
					<form id="changepass" class="form-horizontal" role="form" action="changepassword" method="post" modelAttribute="User" data-parsley-validate>
						<div class="col-lg-12">
							<div class="formDetailsMain">
								<div class="formDetailsMainHead RegisterNewConsumer password ">
									<h1>Change Password</h1>
								<font color="red">${message}</font>
								</div>
							</div>
						</div>
						
						<div class="col-lg-11 C_margin" id="cmplland">
							<div class="signleftbox">
								<h3>Current Password : <font color="red">*</font></h3>
							</div>
							<div class="signrightbox">

								<input type="password" class="form-control" minlength="1" id="cpassword" name="cpassword"
									data-parsley-required="true" />

							</div>
						</div>
						
						<div class="col-lg-11 C_margin" id="cmplland">
							<div class="signleftbox">
								<h3>New Password : <font color="red">*</font></h3>
							</div>
							<div class="signrightbox">

								<input type="password" class="form-control" minlength="1" id="newPassword" name="newPassword"
									data-parsley-notequalto="#cpassword" data-parsley-required="true" />

							</div>
						</div>

						<div class="col-lg-11 C_margin" id="cmplland">
							<div class="signleftbox">
								<h3>Confirm Password : <font color="red">*</font></h3>
							</div>
							<div class="signrightbox">

								<input type="password" class="form-control" minlength="1" id="confirmPassword" data-parsley-equalto="#newPassword" name="confirmPassword"
									data-parsley-equalto-message="New Password and confirm password should be same." data-parsley-required="true" />

							</div>
						</div>
				
				<div class="change passwordform">
					<div class="col-lg-12 " style="padding-top: 40px;">
						<div class="col-lg-6">
							<button type="submit" tabindex='11' id="red"
								class="btn btn-lg btn-primary registerBtn"
								style="margin-right: -40px;">Change Password</button>
						</div>
						<div class="col-lg-6">
							<button type="reset" tabindex='12'
								class="btn btn-lg btn-primary cancelBtn"
								style="margin-left: 40px;">Reset</button>
						</div>
					</div>
				</div>
				</form>
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
	<script>
	window.Parsley.addValidator('notequalto', 
	    function (value, requirement) {
	        return value !== $(requirement).val();
	    }, 32)
	    .addMessage('en', 'notequalto', 'Current password and new password can not be same.');
</script>

	<script>
		$(document).ready(function() {
			/* $('#changepass').submit(function(event){

				data = $('#newPassword').val();
				var len = data.length;
				if($('#cpassword').val().length == 0 ){
					alert("Current password cannot be blank");
				}
				if($('#cpassword').val()==$('#nemPassword').val()){
					alert("Current password and New password cannot be same");
				}
				if (len < 1) {
					alert("Password cannot be blank");
					// Prevent form submission
					event.preventDefault();
				}

				if ($('#nemPassword').val()) {

					alert("Password and Confirm Password don't match");
					$('input[type="password"]').val('');

					// Prevent form submission
					event.preventDefault();
				}

			}); */
		});
		function download(){
			  $.ajax({
					url : "${req.requestURL}/SCS-Assignment/download" ,
					type: "POST",
					data : {
						url : "ScsProject"
					},
					success: function(data, textStatus, jqXHR)
					{
						//data - response from server
					},
					error: function (jqXHR, textStatus, errorThrown)
					{

					}
				});
		  }
	</script>
</body>
</html>
</sec:authorize>