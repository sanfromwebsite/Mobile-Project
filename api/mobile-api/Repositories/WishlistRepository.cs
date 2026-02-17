using mobile_api.Data;
using mobile_api.DTOs.Wishlist;
using mobile_api.Interfaces;
using mobile_api.Models;
using Microsoft.EntityFrameworkCore;

namespace mobile_api.Repositories
{
    public class WishlistRepository : IWishlistRepository
    {
        private readonly Database _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public WishlistRepository(Database context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<List<WishlistItemDto>> GetUserWishlist(int userId)
        {
            var wishlistItems = await _context.Wishlists
                .Where(w => w.UserId == userId)
                .Include(w => w.Book)
                    .ThenInclude(b => b.Author)
                .Include(w => w.Book)
                    .ThenInclude(b => b.Discounts)
                .Include(w => w.Book)
                    .ThenInclude(b => b.Category)
                .Select(w => new WishlistItemDto
                {
                    Id = w.Id,
                    UserId = w.UserId,
                    Book = new DTOs.Book.BookDto
                    {
                        Id = w.Book.Id,
                        Name = w.Book.Name,
                        Photo = w.Book.Photo,
                        AuthorId = w.Book.AuthorId,
                        AuthorName = w.Book.Author.Name,
                        Desc = w.Book.desc,
                        StockQty = w.Book.StockQty,
                        Price = w.Book.Price,
                        CreatedAt = w.Book.CreatedAt,
                        UpdatedAt = w.Book.UpdatedAt,
                        Discounts = w.Book.Discounts.Select(d => new DTOs.Book.BookDiscountDto
                        {
                            Id = d.Id,
                            DiscountPercentage = d.DiscountPercentage,
                            StartDate = d.StartDate,
                            EndDate = d.EndDate
                        }).ToList(),
                        CategoryName = w.Book.Category != null ? w.Book.Category.Name : string.Empty,
                        Categories = w.Book.BookCategories.Select(bc => bc.Category.Name).ToList()
                    }
                }).ToListAsync();

            var request = _httpContextAccessor.HttpContext?.Request;
            if (request != null)
            {
                var baseUrl = $"{request.Scheme}://{request.Host}";
                foreach (var item in wishlistItems)
                {
                    if (!string.IsNullOrEmpty(item.Book.Photo))
                    {
                        item.Book.Photo = $"{baseUrl}/{item.Book.Photo}";
                    }
                }
            }

            return wishlistItems;
        }

        public async Task<Wishlist?> AddToWishlist(int userId, AddToWishlistDto addToWishlistDto)
        {
            var exists = await _context.Wishlists
                .AnyAsync(w => w.UserId == userId && w.BookId == addToWishlistDto.BookId);

            if (exists) return null;

            var wishlistItem = new Wishlist
            {
                UserId = userId,
                BookId = addToWishlistDto.BookId
            };

            await _context.Wishlists.AddAsync(wishlistItem);
            await _context.SaveChangesAsync();
            return wishlistItem;
        }

        public async Task<bool> RemoveFromWishlist(int userId, int WishlistId)
        {
            var item = await _context.Wishlists
                .FirstOrDefaultAsync(w => w.Id == WishlistId && w.UserId == userId);

            if (item == null) return false;

            _context.Wishlists.Remove(item);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
