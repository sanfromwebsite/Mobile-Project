using mobile_api.DTOs.Wishlist;
using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface IWishlistRepository
    {
        Task<List<WishlistItemDto>> GetUserWishlist(int userId);
        Task<Wishlist?> AddToWishlist(int userId, AddToWishlistDto addToWishlistDto);
        Task<bool> RemoveFromWishlist(int userId, int WishlistId);
    }
}
