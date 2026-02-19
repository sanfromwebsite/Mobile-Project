using mobile_api.Data;
using mobile_api.DTOs.Cart;
using mobile_api.Interfaces;
using mobile_api.Models;
using Microsoft.EntityFrameworkCore;

namespace mobile_api.Repositories
{
    public class CartRepository : ICartRepository
    {
        private readonly Database _context;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public CartRepository(Database context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<List<CartItemDto>> GetUserCart(int userId)
        {
            var cartItems = await _context.Carts
                .Where(c => c.UserId == userId)
                .Include(c => c.Book)
                    .ThenInclude(b => b.Author)
                .Include(c => c.Book)
                    .ThenInclude(b => b.Discounts)
                .Include(c => c.Book)
                    .ThenInclude(b => b.Category)
                .Select(c => new CartItemDto
                {
                    Id = c.Id,
                    UserId = c.UserId,
                    Qty = c.Qty,
                    Book = new DTOs.Book.BookDto
                    {
                        Id = c.Book.Id,
                        Name = c.Book.Name,
                        Photo = c.Book.Photo,
                        AuthorId = c.Book.AuthorId,
                        AuthorName = c.Book.Author.Name,
                        Desc = c.Book.desc,
                        StockQty = c.Book.StockQty,
                        Price = c.Book.Price,
                        CreatedAt = c.Book.CreatedAt,
                        UpdatedAt = c.Book.UpdatedAt,
                        Discounts = c.Book.Discounts.Select(d => new DTOs.Book.BookDiscountDto
                        {
                            Id = d.Id,
                            DiscountPercentage = d.DiscountPercentage,
                            StartDate = d.StartDate,
                            EndDate = d.EndDate
                        }).ToList(),
                        CategoryName = c.Book.Category != null ? c.Book.Category.Name : string.Empty,
                        Categories = c.Book.BookCategories.Select(bc => bc.Category.Name).ToList()
                    }
                }).ToListAsync();

            var request = _httpContextAccessor.HttpContext?.Request;
            if (request != null)
            {
                var baseUrl = $"{request.Scheme}://{request.Host}";
                foreach (var item in cartItems)
                {
                    if (!string.IsNullOrEmpty(item.Book.Photo))
                    {
                        item.Book.Photo = $"{baseUrl}/{item.Book.Photo}";
                    }
                }
            }

            return cartItems;
        }

        public async Task<Cart> AddToCart(int userId, AddToCartDto addToCartDto)
        {
            var existingItem = await _context.Carts
                .FirstOrDefaultAsync(c => c.UserId == userId && c.BookId == addToCartDto.BookId);

            if (existingItem != null)
            {
                existingItem.Qty += addToCartDto.Qty;
                await _context.SaveChangesAsync();
                return existingItem;
            }

            var cartItem = new Cart
            {
                UserId = userId,
                BookId = addToCartDto.BookId,
                Qty = addToCartDto.Qty
            };

            await _context.Carts.AddAsync(cartItem);
            await _context.SaveChangesAsync();
            return cartItem;
        }

        public async Task<bool> RemoveFromCart(int userId, int cartId)
        {
            var item = await _context.Carts
                .FirstOrDefaultAsync(c => c.Id == cartId && c.UserId == userId);

            if (item == null) return false;

            _context.Carts.Remove(item);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> ClearCart(int userId)
        {
            var items = await _context.Carts.Where(c => c.UserId == userId).ToListAsync();
            if (!items.Any()) return true;

            _context.Carts.RemoveRange(items);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
