package com.example;

import java.util.Date;

public class Book {
    private int id;
    private String title;
    private String author;
    private String isbn;
    private String publisher;
    private String genre;
    private int publicationYear;
    private double price;
    private Date createdAt;
    
    public Book() {}
    
    public Book(int id, String title, String author, String isbn, String publisher, 
                String genre, int publicationYear, double price, Date createdAt) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.publisher = publisher;
        this.genre = genre;
        this.publicationYear = publicationYear;
        this.price = price;
        this.createdAt = createdAt;
    }
    
    public Book(String title, String author, String isbn, String publisher, 
                String genre, int publicationYear, double price) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.publisher = publisher;
        this.genre = genre;
        this.publicationYear = publicationYear;
        this.price = price;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public String getGenre() {
        return genre;
    }
    
    public void setGenre(String genre) {
        this.genre = genre;
    }
    
    public int getPublicationYear() {
        return publicationYear;
    }
    
    public void setPublicationYear(int publicationYear) {
        this.publicationYear = publicationYear;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Book{id=" + id + ", title='" + title + "', author='" + author + 
               "', isbn='" + isbn + "', publisher='" + publisher + "'}";
    }
}
