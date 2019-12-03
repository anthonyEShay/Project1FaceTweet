<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="java.util.List" %>
<%--     <%@ taglib uri="http://java.sun.com/jsp/jst1/core" prefix="c" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tweets Page</title>
<style>
.navbar{
	list-style-type: none;
	overflow: hidden;
	margin: 0;
	padding: 0;
	background-color: blue;
}

.navbar li {
	float: left;
}

li a {
	display: block;
	color: black;
	text-align: center;
	text-decoration: none;
	padding: 16px;
}

li a:hover{
	background-color: #23d3ff;
}
</style>
</head>
<body onload="extractInfo();">
<div><h1>Tweet Page</h1></div>
<ul class = "navbar">
<li><a href="/hello">Tweet Page</a></li>
<li><a href="/Friends">Friends Page</a></li>
<li><a href="/TopTweet">Top Tweets</a></li>
</ul>

<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v5.0&appId=526949021195260&autoLogAppEvents=1"></script>

<center><h1>Exercise Facebook Tweet</h1></center>
<center><h2>Begin!</h2></center>
<script type="text/javascript">
var first_name;
var last_name;
var picture;
// initialize and setup facebook js sdk
window.fbAsyncInit = function() {
   FB.init({
     appId      : '466551270732561',
     cookie     : true,
     xfbml      : true,
     version    : 'v2.5'
   });
   
   FB.AppEvents.logPageView(); 
   
   FB.getLoginStatus(function(response) {
	   //statusChangeCallback(response);
    if (response.status === 'connected') {
    	var myString = '<p>Status = Connected</p>' +
    	'<p>You are logged into Facebook, and you are logged into the app. Great!</p>';
    document.getElementById('status').innerHTML = myString;
    
    document.getElementById('login').style.visibility = 'hidden';
    document.getElementById('loginBut2').style.visibility = 'hidden';
    document.getElementById('loginBut3').style.visibility = 'hidden';
    } 
    else if (response.status === 'not_authorized') {
    	var myString = '<p>Status = Not Authorized</p>' +
    	'<p>You are logged into Facebook, but have not logged into the app</p>' +
        '<p>Please press the login button below</p>';
    document.getElementById('status').innerHTML = myString;
    } 
    else {
    document.getElementById('status').innerHTML = '<p>You are not logged into Facebook or the App</p>';
    }
   });
};

(function(d, s, id){
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/en_US/sdk.js";
   fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// login with facebook with extra permissions
function login() {
FB.login(function(response) {
	if (response.status === 'connected') {
    	var myString = '<p>Status = Connected</p>' +
    	'<p>You are logged into Facebook, and you are logged into the app. Great!</p>';
    document.getElementById('status').innerHTML = myString;
    
    document.getElementById('login').style.visibility = 'hidden';
    document.getElementById('loginBut2').style.visibility = 'hidden';
    document.getElementById('loginBut3').style.visibility = 'hidden';
    } 
    else if (response.status === 'not_authorized') {
    	var myString = '<p>Status = Not Authorized</p>' +
    	'<p>You are logged into Facebook, but have not logged into the app</p>' +
        '<p>Please press the login button below</p>';
    document.getElementById('status').innerHTML = myString;
    } 
    else {
    document.getElementById('status').innerHTML = '<p>You are not logged into Facebook or the App</p>';
    }
}, {scope: 'email,user_birthday'}); //,publish_actions
}

function logout(){
	FB.logout(function(response) {
		if (response.status === 'connected') {
	    	var myString = '<p>Status = Connected</p>' +
	    	'<p>You are logged into Facebook, and you are logged into the app. Great!</p>';
	    document.getElementById('status').innerHTML = myString;
	    } 
	    else if (response.status === 'not_authorized') {
	    	var myString = '<p>Status = Not Authorized</p>' +
	    	'<p>You are logged into Facebook, but are no longer logged into the app</p>' +
	        '<p>Please press the login button below to continue with the app</p>';
	    document.getElementById('status').innerHTML = myString;
	    document.getElementById('login').style.visibility = 'visible';
	    document.getElementById('loginBut2').style.visibility = 'visible';
	    document.getElementById('loginBut3').style.visibility = 'visible';
	    } 
	    else {
	    document.getElementById('status').innerHTML = '<p>You are no longer logged into Facebook or the App</p>';
	    document.getElementById('login').style.visibility = 'visible';
	    document.getElementById('loginBut2').style.visibility = 'visible';
	    document.getElementById('loginBut3').style.visibility = 'visible';
	    }
		});
}

// getting basic user info
function getInfo() {
FB.api('/me', 'GET', {fields: 'first_name,last_name,name,id,birthday'}, function(response) {
document.getElementById('status').innerHTML = response.birthday;
});
}

function testMessageCreate(){
FB.ui({
method:'share',
href:'https://www.facebook.com/nima.thokozani.3'
},function(response){
    if (response && !response.error_message) {
        alert('Posting completed.');
      } else {
        alert('Error while posting.');
      }
    }
)};
function get_ageInfo() {

FB.api('/me', 'get', {fields: 'birthday'}, function(response) {
console.log(response);
console.log(calculate_age(response.birthday));
document.getElementById('status').innerHTML = calculate_age(response.birthday);
});

}
function calculate_age(dateString) {
       var today = new Date();
   var birthDate = new Date(dateString);
   var age = today.getFullYear() - birthDate.getFullYear();
   var m = today.getMonth() - birthDate.getMonth();
   if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate()))
   {
       age--;
   }
   return age;
}

function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
    document.getElementById('status').innerHTML = 'Made it';
  });
}

function shareTweet(){
	checkLoginState();
	extractInfo()
	FB.ui({method: 'share',
		href: document.getElementById("status2").value,
		//quote: document.getElementById('text_content').value,
		},function(response){
		if (!response || response.error)
		{
			console.log(response.error);
			alert('Posting error occured');
		}
	});
	
};


function extractInfo(){
	FB.api('/me', 
			'GET',
			{"fields":"id,first_name,last_name"},
			function(response){
				first_name = response.first_name;
				console.log(response);
				 document.cookie="user_id="+response.id;
				last_name = response.last_name;
				document.cookie="first_name="+first_name;
				localStorage.setItem('first_name',first_name);
				document.cookie="last_name="+last_name;
				localStorage.setItem('last_name',last_name);
				console.log(document.cookie);
				document.getElementById("puser_id").innerHTML = response.id;
				document.getElementById("pfirst_name").innerHTML = first_name;
			});
	picture = "<img src=\"//graph.facebook.com/" + getCookie('user_id') + "/picture\"/>";
	document.cookie="picture="+picture;
	localStorage.setItem('picture',picture);
	FB.api(
			  "/me/picture",
			  function(response) {
			      // Insert your code here
				  picture = "<img src='" + response.data.url + "'>";
				  //document.getElementById('status').innerHTML = "Dude" + response.data.url;
				  document.cookie="picture="+picture;
				localStorage.setItem('picture',picture);
				if (response && ! response.error){
					//document.getElementById('status').innerHTML = "Dude3";
					picture = "<img src='" + "http://monsterdaygreeley.com/wp-content/uploads/2017/06/gremlinsquare.jpg" + "'>";
					document.cookie="picture="+picture;
					localStorage.setItem('picture',picture);
				}
			  }
			);
	 document.getElementById("user_ids").value    = getCookie('user_id');
	document.getElementById("user_id").value    = getCookie('user_id');
	document.getElementById("first_name").value = getCookie('first_name');
	document.getElementById("last_name").value  = getCookie('last_name');
	document.getElementById("picture").value    = getCookie('picture');
	//document.getElementById("toptweet").href   ="toptweet.jsp?id="+localStorage.getItem("first_name");
	console.log(document.getElementById("first_name").value);
	console.log(document.getElementById("last_name").value);
	console.log(document.getElementById("picture").value);
};


function getCookie(cname) {
	var re = new RegExp(cname + "=([^;]+)");
	var value = re.exec(document.cookie);
	return (value != null) ? unescape(value[1]) : null;
}


function sendDirectMsg(){
	checkLoginState();
	extractInfo()
	temp = String(document.getElementById("status2").value)
	FB.ui({method:  'send',
		  link: temp,
		  });
	console.log(document.getElementById("status2"));
};
</script>

<div style="float: right; style: block;">
<div id="loginBut3">
<fb:login-button 
  scope="public_profile, email, user_birthday"
  onlogin="checkLoginState();">
</fb:login-button>
</div>
<button onclick="login()" id="login">Login to the App</button>
<br>
<button onclick="logout()" id="logout">Logout of the App</button>
</div>
<p>&nbsp;</p>
<div id="status"></div>
<br>


<br><div align="center">
<script type="text/javascript">
extractInfo();
</script>
<div><h2>Hello <span id="pfirst_name">=(</span>, ID : <span id="puser_id">=(</span></h2></div>
<input type="button"  class="button" value="Load In User Data" name="load data" onclick=extractInfo() />
<br>
<script type="text/javascript">callme()</script>
<br>
<h3>Currently Selected Tweet URL:</h3>
<br>
<%
if(null != request.getParameter("status2")){
	request.setAttribute("status2",request.getAttribute("status2"));
}
%>
${status2}
<input type=hidden id="status2" value="${status2}">
<br><br>

<table>
<tr>
<form id="storegae" action="GaeStore" method="get" name="storegae"  >
<td>
<textarea id="text_content" name="text_content" class="textarea"
			placeholder="Enter Your Tweet Text" rows="5" cols="50"></textarea></td>
<input type=hidden id="user_id" name= "user_id" value="No user ID"/>
<input type=hidden id="first_name" name="first_name" value = "No First Name"/>
<input type=hidden id="last_name" name="last_name" value = "No Last Name" />
<input type=hidden id="picture" name="picture"  value = "No Picture Found"/>
    
<script>
console.log(document.getElementById("first_name")+" "+document.getElementById("last_name")+" "+document.getElementById("picture"));
extractInfo();
</script>
    
<td><input type="submit" id=submit name=save class="button" value="Submit to GAE"/>
</form>

<br>
<h2>Submit to Facebook by:</h2>
<input type="button"  class="button" value="Post/Share" name="share_tweet" onclick=shareTweet() />
<input type="button"  class="button" value="Send Direct Message" name="send_direct_msg" onclick=sendDirectMsg() />

</td>
</tr>
</table>
</div>


<div>
<form action="GetTweets" method="GET">
<input type=hidden id=user_ids name=user_ids  />
<br><input type="submit"  class="button" value="View my Tweets" name="view_tweet" />
</form>
</div>




<script>

var modal = document.getElementById('mypopup');
var btn = document.getElementById("create_tweet");
var span = document.getElementsByClassName("close")[0];
btn.onclick = function() {
    modal.style.display = "block";
};
span.onclick = function() {
    modal.style.display = "none";
};
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
};
document.getElementById("user_ids").value       = getCookie('user_id');
document.getElementById("user_id").value       = getCookie('user_id');
document.getElementById("first_name").value = getCookie('first_name');
document.getElementById("first_names").value = getCookie('first_name');
document.getElementById("last_name").value  = getCookie('last_name');
document.getElementById("picture").value    = getCookie('picture');
document.getElementById("toptweet").href="toptweet.jsp?name="+getCookie("first_name");

</script>



</body>
</html>