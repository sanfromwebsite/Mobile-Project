using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class OrderDetail
    {
        [Key]
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int BookId { get; set; }
        public int Quantity { get; set; }
        public DateTime CreatedAt { get; set; }
        public decimal Price { get; set; }
        public virtual Order Order { get; set; } = null!;
        public virtual Book Book { get; set; } = null!;
    }
}
