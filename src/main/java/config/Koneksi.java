/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Koneksi {
    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/dbkopi",
                "postgres",
                "admin"
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
}
