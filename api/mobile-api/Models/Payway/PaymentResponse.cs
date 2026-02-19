
namespace mobile_api.Models.Payway
{
    public class PaymentResponse
    {
        public string QRToken { get; set; } = "";
        public string MD5 { get; set; } = "";
        public string BillNumber { get; set; } = "";
    }
}