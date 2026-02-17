namespace mobile_api.DTOs.Book
{
    public class BookDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Photo { get; set; } = string.Empty;
        public int AuthorId { get; set; }
        public string AuthorName { get; set; } = string.Empty;
        public string Desc { get; set; } = string.Empty;
        public int StockQty { get; set; }
        public decimal Price { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public List<BookDiscountDto> Discounts { get; set; } = new List<BookDiscountDto>();
        public string CategoryName { get; set; } = string.Empty;
        public List<string> Categories { get; set; } = new List<string>();
    }

    public class BookCategoryDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }

    public class BookDiscountDto
    {
        public int Id { get; set; }
        public decimal DiscountPercentage { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}
