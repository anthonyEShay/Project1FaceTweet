

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

/**
 * Servlet implementation class GaeStore
 */
@WebServlet("/GaeStore")
public class GaeStore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GaeStore() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		Entity e = new Entity("tweet");
		e.setProperty("status",req.getParameter("text_content"));
		e.setProperty("user_id",req.getParameter("user_id"));
		e.setProperty("first_name",req.getParameter("first_name"));
		e.setProperty("last_name",req.getParameter("last_name"));
		e.setProperty("picture",req.getParameter("picture"));
		e.setProperty("visited_count", 0);
		Cookie user_id = new Cookie("user_id", req.getParameter("user_id"));
		Cookie f_name= new Cookie("first_name",req.getParameter("first_name"));
		Cookie l_name=new Cookie("last_name", req.getParameter("last_name"));
		Cookie pic = new Cookie("picture", req.getParameter("picture"));
		resp.addCookie(user_id);
		resp.addCookie(f_name);
		resp.addCookie(l_name);
		resp.addCookie(pic);
		Date date = new Date();
        System.out.println(sdf.format(date));
		e.setProperty("timestamp", sdf.format(date));
		Key id=ds.put(e);		
		StringBuffer sb=new StringBuffer();
		String url = req.getRequestURL().toString();
		String baseURL = url.substring(0, url.length() - req.getRequestURI().length()) + req.getContextPath() + "/";
		sb.append(baseURL+"direct_tweet?id="+id.getId());
		req.setAttribute("status2", sb);
		RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/home.jsp");
	    try {
			jsp.forward(req, resp);
		} catch (ServletException f) {
			// TODO Auto-generated catch block
			f.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
