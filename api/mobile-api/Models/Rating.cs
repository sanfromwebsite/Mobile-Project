using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class Rating
    {
        [Key]
        public int Id { get; set; }
        public int UserId { get; set; }
        public decimal Star { get; set; }
        public int BookId { get; set; }
        public virtual User User { get; set; } = null!;
        public virtual Book Book { get; set; } = null!;
    }
}
