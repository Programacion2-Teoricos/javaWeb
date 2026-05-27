package modelo.vo;

public class PersonaVO {
    private int codigo;
    private String nombre;

    public PersonaVO() {}

    public PersonaVO(int codigo, String nombre) {
        this.codigo = codigo;
        this.nombre = nombre;
    }

    public int getCodigo()           { return codigo; }
    public void setCodigo(int c)     { this.codigo = c; }
    public String getNombre()        { return nombre; }
    public void setNombre(String n)  { this.nombre = n; }

    @Override
    public String toString() {
        return "PersonaVO{codigo=" + codigo + ", nombre='" + nombre + "'}";
    }
}
