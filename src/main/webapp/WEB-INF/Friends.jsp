<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Friends Page</title>
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
<body>
<div><h1>Friends Page</h1></div>
<ul class="navbar">
<li><a href="/hello">Tweet Page</a></li>
<li><a href="/Friends">Friends Page</a></li>
<li><a href="/TopTweet">Top Tweets</a></li>
</ul>
<br>
<p>Should Show all the user's friends of this app
<br>In a scrollable list show all of friends tweets
<br>Make sure to implement a visited counter for that tweet every time they are displayed</p>
</body>
</html>