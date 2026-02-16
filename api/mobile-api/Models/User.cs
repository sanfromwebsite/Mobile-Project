using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace mobile_api.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public int RoleId { get; set; }
        public int is_active { get; set; }
        public DateTime created_at { get; set; }
        public DateTime updated_at { get; set; }
        public virtual Role Role { get; set; } = null!;
        public virtual UserProfile Profile { get; set; } = null!;
        public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
        public virtual ICollection<Wishlist> Wishlists { get; set; } = new List<Wishlist>();
        public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();
        public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    }
}