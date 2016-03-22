<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
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
	   
	   <style>
	    .parsley-required
		{
		 margin-top:0px;
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
  <body >
	<div class="container" id="container" style="display:block;padding-top:30px;">
		<header>
			<!-- Main comapny header -->
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			  <div class="container">
				<div class="navbar-header">
				  <a class="navbar-brand top-navbar-brand" href="#"><img style="margin-top:-13px;max-width:17%;" src="resources/images/icons/SCS-Logo.jpg"/> Source Control System
				  <br/><p style="font-size: 20px; margin-left: 111px;margin-top: -35px;font: italic;color: #428bca;"><i>One step solution for your Source management</i></p></a>
				</div>
				<ul class="nav navbar-nav navbar-right bigger-130 hidden-xs">
					<li><a href="#"><i class="logo"></i></a>
					<img src="resources/images/logo.png" style="    margin-top: -15px; border-radius: 20px;opacity: .7;width: 50px;"/></li>
					
				</ul>
			  </div>
			</nav>
		</header>
		
		<div class="container" > 
		
		
		<div class="col-lg-12" role="navigation" style="margin-bottom: 0;background-color:#f8f8f8;border-color: #e7e7e7;" >
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${req.requestURL}/SCS-Assignment/welcome"><img src="resources/images/home.png"/></a>
                <span class="navbar-brand" style="color: #479AC3;  font-size: 15px;">Welcome&nbsp;&nbsp;${user.username}</span>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                
                <!-- /.dropdown -->
                
                <!-- /.dropdown -->
                
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${req.requestURL}/SCS-Assignment/userProfile"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="${req.requestURL}/SCS-Assignment/change"><i class="fa fa-gear fa-fw"></i> Change Password</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${req.requestURL}/SCS-Assignment/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation" style="margin-top:60px;margin-left:-15px;">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                       
                        <li>
                            <a href="/SCS-Assignment/welcome"><i class="fa fa-dashboard fa-fw"></i> Add user</a>
                        </li>
                        <li>
                            <a href="/SCS-Assignment/userDetails"><i class="fa fa-table fa-fw"></i> User Details</a>
                        </li>
                       
                        
                       
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </div>
		
		
		
		
		
		
			<div class="row" style="margin-top:10px;">
				<div class="col-lg-3" style="float:left;">
                
               <!-- <div class="list-group">
                    <a href="#" class="list-group-item">Add User</a>
                    <a href="#" class="list-group-item">Activate/De-Activate User</a>
                  
                </div>-->
            </div>
			<div id="addUserDiv" class="col-lg-9" style="margin-top:10px;">
			<form id="addUserForm" class="form-horizontal" role="form" data-parsley-validate action="AddUser" method="POST">
				
				<c:if test="${not empty addUserResultMsg}">
				<h4 id="addUserResultMsg">${addUserResultMsg}</h4>
				</c:if>
                <div class="col-lg-12">
				<div class="formDetailsMain">
					<div class="formDetailsMainHead RegisterNewConsumer">
						<h1>Add new User</h1>
					</div>
				</div>
				</div>
				<div class="col-lg-11 C_margin" id="cmplland">
						<div class="signleftbox">
							<h3>
								Username :
							</h3>
						</div>
						<div class="signrightbox">
							
						 <input type="text" class="form-control" id="userName" name="userName" data-parsley-required="true" /> 
							
						</div>
				</div>
				<div class="col-lg-11 C_margin" id="cmplland">
						<div class="signleftbox">
							<h3>
								Email :
							</h3>
						</div>
						<div class="signrightbox">
							
						 <input type="email" class="form-control" id="email" name="email"  data-parsley-required="true"/> 
							
						</div>
				</div>
				
				<div class="col-lg-11 C_margin" id="cmplland">
						<div class="signleftbox">
							<h3>
								Role :
							</h3>
						</div>
						<div class="signrightbox">
						 <label class="radio-inline"></label>
						 <input type="radio" name="userRole" checked="checked" value="nu"/>
						 <span>User </span>
						 <input type="radio" name="userRole"  value="pa" />
						 <span>Project Admin</span>
						</div>
				</div>
				
				<div class="col-lg-11 C_margin" id="rootFolderDiv" style="display: none">
						<div class="signleftbox">
							<h3>
								Root Folder Name :
							</h3>
						</div>
						<div class="signrightbox">
							
						 <input type="text" class="form-control" id="rootFolderName" name="rootFolderName" /> 
							
						</div>
				</div>
				<div class="col-lg-11 C_margin" id="projectUrlDiV" style="width:100%">
						<div class="signleftbox" >
							<h3>
								List of Url's :
							</h3>
						</div>
						<div class="signrightbox" >
							
						<!-- <select id="tokens" class="selectpicker" multiple data-live-search="true" data-parsley-required="true">
							<option data-tokens="URL1">URL1</option>
							<option data-tokens="URL2">URL2</option>
							<option data-tokens="URL3">URL3</option>
						</select>  -->
						<select id="projectUrl" name="projectUrl" multiple>
						
						</select> 
							
						</div>
				</div>
				<div class="row registerFormBtnMain">
					<div class="col-lg-12 " style="padding-top:40px;">
						<div class="col-lg-6">
							<button type="submit" tabindex='11'
								onsubmit=""
								class="btn btn-lg btn-primary registerBtn" style="margin-right:50px;">Create User</button>
						</div>
						<div class="col-lg-6">
							<button type="reset" tabindex='12'
								class="btn btn-lg btn-primary cancelBtn" style="margin-left: -30px;">Reset</button>
						</div>
					</div>
				</div>
            </div><!-- Row Div-->
			</form>
		</div><!-- container Div-->
			

			
		
		<footer>
			<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation" style="min-height: 5%;height: 6%;">
			  <div class="container text-center">
				<div class="footer-content">
				  Copyright @ Persistent System Ltd. All rights reserved. </a>
				</div>
			  </div><!-- /.container-fluid -->
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
	<script src="resources/js/addUser.js"></script>
	

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

    
    $('#rootfolderdiv').hide();
    $('.signrightbox input').on('change', function() {
    	   if($('input[name=role]:checked', '.signrightbox').val() == 'pa')
    		   {
    		   $('#rootfolderdiv').show();
    		   }
    	   else
    		   {
    		   $('#rootfolderdiv').hide();
    		   }
    	});
  });
</script>
  </body>
</html>
</sec:authorize>