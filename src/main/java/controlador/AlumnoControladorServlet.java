package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import modelo.dao.AlumnoDAO;
import modelo.vo.AlumnoVO;

@WebServlet("/alumno")
public class AlumnoControladorServlet extends HttpServlet {
    private final AlumnoDAO dao = new AlumnoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "agregar":
                request.getRequestDispatcher("/vista/alumno-form.jsp").forward(request, response);
                break;
            case "editar":
                mostrarEditar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/alumno");
            return;
        }
        switch (action) {
            case "agregar":    agregar(request, response);    break;
            case "actualizar": actualizar(request, response); break;
            default:           response.sendRedirect(request.getContextPath() + "/alumno");
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("alumnos", dao.listarAlumnos());
        request.getRequestDispatcher("/vista/alumno-lista.jsp").forward(request, response);
    }

    private void agregar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            dao.agregarAlumno(new AlumnoVO(nombre, telefono));
            response.sendRedirect(request.getContextPath() + "/alumno");
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo guardar el alumno: " + e.getMessage());
            request.getRequestDispatcher("/vista/alumno-form.jsp").forward(request, response);
        }
    }

    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int codigo = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("alumno", dao.obtenerAlumnoPorCodigo(codigo));
            request.getRequestDispatcher("/vista/alumno-editar.jsp").forward(request, response);
        } catch (Exception e) {
            listar(request, response);
        }
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int codigo = Integer.parseInt(request.getParameter("codigo"));
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            dao.actualizarAlumno(new AlumnoVO(codigo, nombre, telefono));
            response.sendRedirect(request.getContextPath() + "/alumno");
        } catch (Exception e) {
            mostrarEditar(request, response);
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int codigo = Integer.parseInt(request.getParameter("id"));
            dao.eliminarAlumno(codigo);
        } catch (Exception e) {
            System.err.println("Error al eliminar: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/alumno");
    }
}
