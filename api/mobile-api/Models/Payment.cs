using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class Payment
    {
        [Key]
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int PaymentMethodId { get; set; }
        public int StatusId { get; set; }
        public string TransactionId { get; set; } = string.Empty;
        public DateTime PaymentDate { get; set; }
        public DateTime CreatedAt { get; set; }
        public virtual Order Order { get; set; } = null!;
        public virtual PaymentMethod PaymentMethod { get; set; } = null!;
        public virtual PaymentStatus Status { get; set; } = null!;
    }
}
