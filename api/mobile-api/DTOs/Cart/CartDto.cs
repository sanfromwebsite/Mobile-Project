using mobile_api.DTOs.Book;

namespace mobile_api.DTOs.Cart
{
    public class AddToCartDto
    {
        public int BookId { get; set; }
        public int Qty { get; set; }
    }

    public class UpdateCartQtyDto
    {
        public int Qty { get; set; }
    }

    public class CartItemDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int Qty { get; set; }
        public BookDto Book { get; set; } = new BookDto();
    }
}
