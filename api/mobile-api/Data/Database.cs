using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using mobile_api.Models;

namespace mobile_api.Data
{
    public class Database : DbContext
    {
        public Database(DbContextOptions<Database> options) : base(options) { }
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<Role> Roles { get; set; } = null!;
        public DbSet<UserProfile> UserProfiles { get; set; } = null!;
        public DbSet<Author> Authors { get; set; } = null!;
        public DbSet<Book> Books { get; set; } = null!;
        public DbSet<Wishlist> Wishlists { get; set; } = null!;
        public DbSet<Cart> Carts { get; set; } = null!;
        public DbSet<Rating> Ratings { get; set; } = null!;
        public DbSet<Order> Orders { get; set; } = null!;
        public DbSet<OrderStatus> OrderStatuses { get; set; } = null!;
        public DbSet<OrderDetail> OrderDetails { get; set; } = null!;
        public DbSet<Payment> Payments { get; set; } = null!;
        public DbSet<PaymentMethod> PaymentMethods { get; set; } = null!;
        public DbSet<PaymentStatus> PaymentStatuses { get; set; } = null!;
        public DbSet<BookDiscount> BookDiscounts { get; set; } = null!;
        public DbSet<RevokedToken> RevokedTokens { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // User <-> UserProfile (One-to-One)
            modelBuilder.Entity<User>()
                .HasOne(u => u.Profile)
                .WithOne(p => p.User)
                .HasForeignKey<UserProfile>(p => p.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Order <-> Payment (One-to-One)
            modelBuilder.Entity<Order>()
                .HasOne(o => o.Payment)
                .WithOne(p => p.Order)
                .HasForeignKey<Payment>(p => p.OrderId)
                .OnDelete(DeleteBehavior.Cascade);

            // ============================================
            // ONE-TO-MANY RELATIONSHIPS
            // ============================================

            // Role -> Users (One-to-Many)
            modelBuilder.Entity<User>()
                .HasOne(u => u.Role)
                .WithMany(r => r.Users)
                .HasForeignKey(u => u.RoleId)
                .OnDelete(DeleteBehavior.Restrict);

            // Author -> Books (One-to-Many)
            modelBuilder.Entity<Book>()
                .HasOne(b => b.Author)
                .WithMany(a => a.Books)
                .HasForeignKey(b => b.AuthorId)
                .OnDelete(DeleteBehavior.Restrict);

            // Book -> BookDiscounts (One-to-Many)
            modelBuilder.Entity<BookDiscount>()
                .HasOne(bd => bd.Book)
                .WithMany(b => b.Discounts)
                .HasForeignKey(bd => bd.BookId)
                .OnDelete(DeleteBehavior.Cascade);

            // User -> Orders (One-to-Many)
            modelBuilder.Entity<Order>()
                .HasOne(o => o.User)
                .WithMany(u => u.Orders)
                .HasForeignKey(o => o.UserId)
                .OnDelete(DeleteBehavior.Restrict);

            // OrderStatus -> Orders (One-to-Many)
            modelBuilder.Entity<Order>()
                .HasOne(o => o.Status)
                .WithMany()
                .HasForeignKey(o => o.StatusId)
                .OnDelete(DeleteBehavior.Restrict);

            // Order -> OrderDetails (One-to-Many)
            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Order)
                .WithMany(o => o.OrderDetails)
                .HasForeignKey(od => od.OrderId)
                .OnDelete(DeleteBehavior.Cascade);

            // Book -> OrderDetails (One-to-Many)
            modelBuilder.Entity<OrderDetail>()
                .HasOne(od => od.Book)
                .WithMany(b => b.OrderDetails)
                .HasForeignKey(od => od.BookId)
                .OnDelete(DeleteBehavior.Restrict);

            // PaymentMethod -> Payments (One-to-Many)
            modelBuilder.Entity<Payment>()
                .HasOne(p => p.PaymentMethod)
                .WithMany()
                .HasForeignKey(p => p.PaymentMethodId)
                .OnDelete(DeleteBehavior.Restrict);

            // PaymentStatus -> Payments (One-to-Many)
            modelBuilder.Entity<Payment>()
                .HasOne(p => p.Status)
                .WithMany()
                .HasForeignKey(p => p.StatusId)
                .OnDelete(DeleteBehavior.Restrict);

            // User -> Wishlists (One-to-Many)
            modelBuilder.Entity<Wishlist>()
                .HasOne(w => w.User)
                .WithMany(u => u.Wishlists)
                .HasForeignKey(w => w.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Book -> Wishlists (One-to-Many)
            modelBuilder.Entity<Wishlist>()
                .HasOne(w => w.Book)
                .WithMany()
                .HasForeignKey(w => w.BookId)
                .OnDelete(DeleteBehavior.Cascade);

            // User -> Carts (One-to-Many)
            modelBuilder.Entity<Cart>()
                .HasOne(c => c.User)
                .WithMany(u => u.Carts)
                .HasForeignKey(c => c.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Book -> Carts (One-to-Many)
            modelBuilder.Entity<Cart>()
                .HasOne(c => c.Book)
                .WithMany()
                .HasForeignKey(c => c.BookId)
                .OnDelete(DeleteBehavior.Cascade);

            // User -> Ratings (One-to-Many)
            modelBuilder.Entity<Rating>()
                .HasOne(r => r.User)
                .WithMany(u => u.Ratings)
                .HasForeignKey(r => r.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Book -> Ratings (One-to-Many)
            modelBuilder.Entity<Rating>()
                .HasOne(r => r.Book)
                .WithMany(b => b.Ratings)
                .HasForeignKey(r => r.BookId)
                .OnDelete(DeleteBehavior.Cascade);

            // ============================================
            // SEED DATA
            // ============================================

            // Seed default Roles
            modelBuilder.Entity<Role>().HasData(
                new Role { Id = 1, Name = "Admin" },
                new Role { Id = 2, Name = "User" }
            );

            // Seed default Order Statuses
            modelBuilder.Entity<OrderStatus>().HasData(
                new OrderStatus { Id = 1, Name = "Pending" },
                new OrderStatus { Id = 2, Name = "Processing" },
                new OrderStatus { Id = 3, Name = "Shipped" },
                new OrderStatus { Id = 4, Name = "Delivered" },
                new OrderStatus { Id = 5, Name = "Cancelled" }
            );

            // Seed default Payment Methods
            modelBuilder.Entity<PaymentMethod>().HasData(
                new PaymentMethod { Id = 1, Name = "Cash on Delivery" },
                new PaymentMethod { Id = 2, Name = "Credit Card" },
                new PaymentMethod { Id = 3, Name = "PayPal" },
                new PaymentMethod { Id = 4, Name = "Bank Transfer" }
            );

            // Seed default Payment Statuses
            modelBuilder.Entity<PaymentStatus>().HasData(
                new PaymentStatus { Id = 1, Name = "Pending" },
                new PaymentStatus { Id = 2, Name = "Completed" },
                new PaymentStatus { Id = 3, Name = "Failed" },
                new PaymentStatus { Id = 4, Name = "Refunded" }
            );
        }
    }
}