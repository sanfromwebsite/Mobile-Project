using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class BookCategory
    {
        [Key]
        public int Id { get; set; }
        public int BookId { get; set; }
        public int CategoryId { get; set; }
        public virtual Book Book { get; set; } = null!;
        public virtual Category Category { get; set; } = null!;
    }
}
