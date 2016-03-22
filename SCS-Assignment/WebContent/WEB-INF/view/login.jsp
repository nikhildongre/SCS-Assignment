<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!--  <html>
	<body>
		<h1 id="banner">Spring 3 security MongoDB Demo</h1>  
		<form name="f" action="j_spring_security_check" method="POST">
			<table>
				<tr>
					<td>Username:</td>
					<td><input type='text' name='j_username' /></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type='password' name='j_password'></td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan='2'><input value="Send" name="submit" type="submit">&nbsp;<input value="Reset" name="reset" type="reset"></td>
				</tr>
			</table>
		</form>
	</body>
</html>-->
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
    <link href="resources/css/bootstrap.css" rel="stylesheet">
	<link href="resources/css/parsley.css" rel="stylesheet">
    <link href="resources/css/theme.css" rel="stylesheet">
    <!--<link href="css/font-awesome.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:700,400|Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>
	<link href="css/theme-loading-bar.css" rel="stylesheet" />
	 <link href="css/shop-homepage.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<style>
	 .item img
	 {
	 display: block;
    margin-left: auto;
    margin-right: auto
	 }
	</style>
  </head>
  <body >
	<div class="container" id="container" style="display:block;">
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
		
			<div class="container" style="padding-top:10.5%;"> 
			<div class="row" >
			
             <div class="row carousel-holder" style="padding-top:30px;margin-left:-50px;">

                    <div class="col-md-9" style="position:absolute;padding-top:22px;">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="box-shadow: 0px 0px 20px 1px black;border-radius: 20px;">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                            </ol>
                            <div class="carousel-inner" style="box-shadow: 0px 0px 20px 1px black;border-radius: 20px;">
							
                                <div class="item active">
								  <center>
                                    <img class="slide-image" src="resources/images/image1.jpg" alt="" style="height:330px;">
									</center>
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="resources/images/image2.png" alt="" style="height:330px;">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="resources/images/image3.png" alt="" style="height:330px;">
                                </div>
								<div class="item">
                                    <img class="slide-image" src="resources/images/image5.jpg" alt="" style="height:330px;">
                                </div>
								<div class="item">
                                    <img class="slide-image" src="resources/images/image4.png" alt="" style="height:330px;">
                                </div>
								<div class="item">
                                    <img class="slide-image" src="resources/images/image6.png" alt="" style="height:330px;">
                                </div>
								<div class="item">
                                    <img class="slide-image" src="resources/images/image7.png" alt="" style="height:330px;">
                                </div>
								
                            </div>
                            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev" style="border-radius: 20px;">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next" style="border-radius: 20px;">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                    </div>

                </div>
			

			<section id="form" class="animated fadeInDownn" >
				<div id="loginbox" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2" style="float:right;margin-right:-50px;">                    
					<div class="panel white-alpha-90" >
						<div class="panel-heading">
							<div class="panel-title text-center"><h2>Sign In to <span class="text-primary">SCS</span></h2></div>
						</div>     
						<div class="panel-body" >
							<div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
								<form id="loginform" class="form-horizontal" role="form" data-parsley-validate action="j_spring_security_check" method="POST">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa "><img src="resources/images/user.png" style="width:15px;height:15px;"/></i></span>
									<input id="login-username" type="text" class="form-control" name='j_username' data-parsley-required="true" value="" placeholder="username ">                                        
								</div>
								<div class="input-group">
									<span class="input-group-addon"><i class="fa "><img src="resources/images/pass.png" style="width:15px;height:15px;"/></i></span>
									<input id="login-password" type="password" class="form-control" name='j_password' data-parsley-required="true" placeholder="password">
								</div>
								<!--<div class="input-group">
									<span class="input-group-addon"><i class="fa "><img src="images/url.png" style="width:15px;height:15px;"/></i></span>
									<select id="login-url"  class="form-control" name="url" >
									 <option>Please select one Url to proceed</option>
									</select>
								</div>-->
								<div class="input-group col-xs-12 text-center login-action">
								  <div class="checkbox">
									<label>
									  <!--<input id="login-remember" type="checkbox" name="remember" value="1" style="margin-top: 10px;"> Remember me &nbsp;-->
									  <input value="login" name="submit" type="submit" class="btn btn-success">
									  <span id="btn-reset"><a> <input value="reset" name="reset" type="reset" class="btn btn-success"></a>
									 </span>
									</label>
								  </div>
								</div>
								<div style="margin-top:10px" class="form-group">
									<div class="col-sm-12 controls">
									  
									</div>
								</div>
							</form>     
						</div>                     
					</div>  
				</div>
				</section>
				</div>
			</div>
		
		<footer>
			<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation" style="min-height: 5%;height: 6%;">
			  <div class="container text-center">
				<div class="footer-content">
				  Copyright @ Persistent System Ltd. All rights reserved.2016 </a>
				</div>
			  </div><!-- /.container-fluid -->
			</nav>
		</footer>
	</div>

	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/jquery.backstretch.min.js"></script>
	<script src="resources/js/parsley.js"></script>

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
  </body>
</html>