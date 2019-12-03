package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.SimpleTimeZone;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
	  
	  UserService userService = UserServiceFactory.getUserService();
	  User user = userService.getCurrentUser();
	  String loginUrl = userService.createLoginURL("/");
	  String logoutUrl = userService.createLogoutURL("/");
	  SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSSSSS");
	  
	  request.setAttribute("user", user);
	  request.setAttribute("loginUrl", loginUrl);
	  request.setAttribute("logoutUrl", logoutUrl);
	  request.setAttribute("currentTime", fmt.format(new Date()));

    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    RequestDispatcher jsp = request.getRequestDispatcher("/WEB-INF/home.jsp");
    try {
		jsp.forward(request, response);
	} catch (ServletException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    
    
//    PrintWriter out = response.getWriter();
//
//    out.print("<h1>Hello App Engine!</h1>");
//    fmt.setTimeZone(new SimpleTimeZone(0, ""));
//    out.println("<p>The time is: " + fmt.format(new Date()) + "</p>");
    
    
  }
}