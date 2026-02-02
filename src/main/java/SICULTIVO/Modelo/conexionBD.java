package SICULTIVO.Modelo;

import java.sql.*;


/**
 *
 * @author HP
 */
public class conexionBD {
    //Zona de atributos
    private String jdbcURL;// cadena de conexion
    private String jdbcUSERName;//atributo para el usurio admin DB
    private String jdbcPassword;
    // driver connexion
    private Connection jdbcConnection;// se utiliza un objeto de tipo conexion
    
    
    //ZOna de constructor
    public conexionBD (String jdbcURL,String jdbcUSERName,String jdbcPassword ){
        this.jdbcURL=jdbcURL;
        this.jdbcUSERName=jdbcUSERName;
        this.jdbcPassword=jdbcPassword;
    }
    // Metodo abrir conexion BD
    public void connection() throws SQLException{
       if(jdbcConnection==null || jdbcConnection.isClosed()){
           try{
               Class.forName("com.mysql.cj.jdbc.Driver");//nombre del drive
               System.out.print("Conexion Exitosa");//Imprime en la consola del servidor Glasfish
           }
           catch(ClassNotFoundException ex ){
              System.out.print("Error de conexion"); //Imprime en la consola del servidor Glasfish
              throw new SQLException(ex); 
           }
           //Abrir la conexion
           jdbcConnection=(Connection)DriverManager.getConnection(jdbcURL,jdbcUSERName,jdbcPassword);
       }    
    }
    // Metodo para cerrar conexion 
    public void disconnect() throws SQLException{
        if (jdbcConnection !=null && !jdbcConnection.isClosed()){
            jdbcConnection.close();// Cierro solamente esta abierto 
        }
    }
    // Metodo para obtener la conexion
    public Connection getjdbcConnection(){
        return jdbcConnection;
    }  
}
