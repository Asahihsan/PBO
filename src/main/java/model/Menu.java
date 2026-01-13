package model;

public class Menu {

    private int id;
    private String nama;
    private int harga;
    private String gambar;
    private int idKategori;
    private String namaKategori;

    // Constructor
    public Menu() {
    }

    // ===== GETTER & SETTER =====
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

    public int getHarga() {
        return harga;
    }

    public void setHarga(int harga) {
        this.harga = harga;
    }

    public String getGambar() {
        return gambar;
    }

    public void setGambar(String gambar) {
        this.gambar = gambar;
    }

    public int getIdKategori() {
        return idKategori;
    }

    public void setIdKategori(int idKategori) {
        this.idKategori = idKategori;
    }

    public String getNamaKategori() {
        return namaKategori;
    }

    public void setNamaKategori(String namaKategori) {
        this.namaKategori = namaKategori;
    }

    @Override
    public String toString() {
        return "Menu{"
                + "id=" + id
                + ", nama='" + nama + '\''
                + ", harga=" + harga
                + ", gambar='" + gambar + '\''
                + ", idKategori=" + idKategori
                + ", namaKategori='" + namaKategori + '\''
                + '}';
    }
}
