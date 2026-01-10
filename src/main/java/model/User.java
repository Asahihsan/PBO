package model;

import java.sql.Timestamp;

public class User {

    private int id;
    private String nama;
    private String email;
    private String password;
    private String role;
    private Timestamp createdAt;

    // Constructor
    public User() {
    }

    public User(int id, String nama, String email, String role) {
        this.id = id;
        this.nama = nama;
        this.email = email;
        this.role = role;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{"
                + "id=" + id
                + ", nama='" + nama + '\''
                + ", email='" + email + '\''
                + ", role='" + role + '\''
                + '}';
    }
}
