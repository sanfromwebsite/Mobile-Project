using mobile_api.DTOs.Cart;
using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface ICartRepository
    {
        Task<List<CartItemDto>> GetUserCart(int userId);
        Task<Cart> AddToCart(int userId, AddToCartDto addToCartDto);
        Task<bool> RemoveFromCart(int userId, int cartId);
        Task<bool> ClearCart(int userId);
    }
}
