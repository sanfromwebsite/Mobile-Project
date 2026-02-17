using mobile_api.DTOs.Book;

namespace mobile_api.DTOs.Wishlist
{
    public class AddToWishlistDto
    {
        public int BookId { get; set; }
    }

    public class WishlistItemDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public BookDto Book { get; set; } = new BookDto();
    }
}
