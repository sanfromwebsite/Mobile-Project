using Microsoft.AspNetCore.Http;

namespace mobile_api.DTOs.Book
{
    public class CreateBookDto
    {
        public string Name { get; set; } = string.Empty;
        public IFormFile? Photo { get; set; }
        public int AuthorId { get; set; }
        public int CategoryId { get; set; }
        public string desc { get; set; } = string.Empty;
        public int StockQty { get; set; }
        public decimal Price { get; set; }
        public decimal? DiscountPercentage { get; set; }
        public DateTime? DiscountStartDate { get; set; }
        public DateTime? DiscountEndDate { get; set; }
    }
}