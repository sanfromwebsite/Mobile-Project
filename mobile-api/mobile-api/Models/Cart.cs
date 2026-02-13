using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class Cart
    {
        [Key]
        public int Id { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public int Qty { get; set; }
        public virtual User User { get; set; } = null!;
        public virtual Book Book { get; set; } = null!;
    }
}
