package modelo.vo;

public class AlumnoVO extends PersonaVO {
    private String telefono;

    public AlumnoVO() {}

    // Sin código — para INSERT con AUTO_INCREMENT
    public AlumnoVO(String nombre, String telefono) {
        super();
        this.setNombre(nombre);
        this.telefono = telefono;
    }

    // Constructor completo — para SELECT (código ya existe en BD)
    public AlumnoVO(int codigo, String nombre, String telefono) {
        super(codigo, nombre);
        this.telefono = telefono;
    }

    public String getTelefono()          { return telefono; }
    public void setTelefono(String tel)  { this.telefono = tel; }

    @Override
    public String toString() {
        return "AlumnoVO{codigo=" + getCodigo() + ", nombre='" + getNombre()
                + "', telefono='" + telefono + "'}";
    }
}
