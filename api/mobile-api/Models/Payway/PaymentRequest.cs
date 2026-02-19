namespace mobile_api.Models.Payway
{
    public class PaymentRequest
    {
        public decimal Amount { get; set; }
        public string? BillNumber { get; set; }
        public string? MobileNumber { get; set; }
    }
}
