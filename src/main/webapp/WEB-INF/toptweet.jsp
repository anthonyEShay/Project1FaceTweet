<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Top Tweet Page</title>
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
<p>Display in order of most popular all Tweets
<br>use visited counter to determine popularity</p>
</body>
</html>