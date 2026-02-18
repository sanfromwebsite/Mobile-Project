using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class Author
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Photo {get; set;} = string.Empty;
        public virtual ICollection<Book> Books { get; set; } = new List<Book>();
    }
}
