using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Cart;
using mobile_api.Interfaces;
using System.Security.Claims;

namespace mobile_api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CartController : ControllerBase
    {
        private readonly ICartRepository _cartRepository;

        public CartController(ICartRepository cartRepository)
        {
            _cartRepository = cartRepository;
        }

        private int GetUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null) return 0;
            return int.Parse(userIdClaim.Value);
        }

        [HttpGet]
        public async Task<IActionResult> GetCart()
        {
            var userId = GetUserId();
            var cart = await _cartRepository.GetUserCart(userId);
            return Ok(new { result = true, data = cart });
        }

        [HttpPost("add")]
        public async Task<IActionResult> AddToCart([FromForm] AddToCartDto addToCartDto)
        {
            var userId = GetUserId();
            var cartItem = await _cartRepository.AddToCart(userId, addToCartDto);
            return Ok(new { result = true, message = "Item added to cart", data = cartItem });
        }

        [HttpDelete("remove/{cartId}")]
        public async Task<IActionResult> RemoveFromCart(int cartId)
        {
            var userId = GetUserId();
            var success = await _cartRepository.RemoveFromCart(userId, cartId);
            if (!success) return NotFound(new { result = false, message = "Cart item not found" });

            return Ok(new { result = true, message = "Item removed from cart" });
        }

        [HttpDelete("clear")]
        public async Task<IActionResult> ClearCart()
        {
            var userId = GetUserId();
            await _cartRepository.ClearCart(userId);
            return Ok(new { result = true, message = "Cart cleared" });
        }
    }
}
