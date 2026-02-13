using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class PaymentStatus
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }
}
