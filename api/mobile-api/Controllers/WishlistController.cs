using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Wishlist;
using mobile_api.Interfaces;
using System.Security.Claims;

namespace mobile_api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class WishlistController : ControllerBase
    {
        private readonly IWishlistRepository _wishlistRepository;

        public WishlistController(IWishlistRepository wishlistRepository)
        {
            _wishlistRepository = wishlistRepository;
        }

        private int GetUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null) return 0;
            return int.Parse(userIdClaim.Value);
        }

        [HttpGet]
        public async Task<IActionResult> GetWishlist()
        {
            var userId = GetUserId();
            var wishlist = await _wishlistRepository.GetUserWishlist(userId);
            return Ok(new { result = true, data = wishlist });
        }

        [HttpPost("add")]
        public async Task<IActionResult> AddToWishlist([FromForm] AddToWishlistDto addToWishlistDto)
        {
            var userId = GetUserId();
            var item = await _wishlistRepository.AddToWishlist(userId, addToWishlistDto);
            if (item == null) return BadRequest(new { result = false, message = "Item already in wishlist" });
            return Ok(new { result = true, message = "Item added to wishlist", data = item });
        }

        [HttpDelete("remove/{wishlistId}")]
        public async Task<IActionResult> RemoveFromWishlist(int wishlistId)
        {
            var userId = GetUserId();
            var success = await _wishlistRepository.RemoveFromWishlist(userId, wishlistId);
            if (!success) return NotFound(new { result = false, message = "Wishlist item not found" });

            return Ok(new { result = true, message = "Item removed from wishlist" });
        }

    }
}
