package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import modelo.dao.PersonaDAO;
import modelo.vo.PersonaVO;

@WebServlet("/persona")
public class PersonaControladorServlet extends HttpServlet {
    private final PersonaDAO dao = new PersonaDAO();

    // ======================== GET ========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "agregar":
                request.getRequestDispatcher("/vista/persona-form.jsp")
                        .forward(request, response);
                break;
            case "cargarEditar":
                cargarEditar(request, response);
                break;
            case "listar":
            default:
                listar(request, response);
                break;
        }
    }

    // ======================== POST ========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/persona");
            return;
        }

        switch (action) {
            case "agregar":
                agregar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/persona");
        }
    }

    // ===================== Acciones privadas =====================
    private void agregar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nombre = request.getParameter("nombre").trim();
        dao.agregar(new PersonaVO(codigo, nombre));
        response.sendRedirect(request.getContextPath() + "/persona");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nombre = request.getParameter("nombre").trim();
        dao.actualizar(new PersonaVO(codigo, nombre));
        response.sendRedirect(request.getContextPath() + "/persona");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        dao.eliminar(codigo);
        response.sendRedirect(request.getContextPath() + "/persona");
    }

    private void cargarEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        PersonaVO persona = dao.obtenerXCodigo(codigo);
        if (persona != null) {
            request.setAttribute("persona", persona);
            request.getRequestDispatcher("/vista/persona-editar.jsp")
                    .forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/persona");
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("personas", dao.getLista());
        request.getRequestDispatcher("/vista/persona-lista.jsp")
                .forward(request, response);
    }
}
