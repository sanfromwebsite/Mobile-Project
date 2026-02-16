using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class BookDiscount
    {
        [Key]
        public int Id { get; set; }
        public int BookId { get; set; }
        public decimal DiscountPercentage { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public virtual Book Book { get; set; } = null!;
    }
}
