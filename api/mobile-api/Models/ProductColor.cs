using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class ProductColor
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int BookId { get; set; }

        public virtual Book Book { get; set; } = null!;
    }
}
