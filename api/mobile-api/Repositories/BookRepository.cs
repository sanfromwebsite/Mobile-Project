using mobile_api.Data;
using mobile_api.Models;
using Microsoft.EntityFrameworkCore;

using mobile_api.Interfaces;
using mobile_api.DTOs.Book;

namespace mobile_api.Repositories
{
    public class BookRepository : IBookRepository
    {
        private readonly Database _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public BookRepository(Database context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<List<Book>> GetAllBooks()
        {
            return await _context.Books
                .Include(b => b.Discounts)
                .Include(b => b.Author)
                .ToListAsync();
        }

        public async Task<Book> CreateBook(CreateBookDto createBook)
        {
            string photoPath = string.Empty;

            if (createBook.Photo != null)
            {
                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "books");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(createBook.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await createBook.Photo.CopyToAsync(stream);
                }

                photoPath = Path.Combine("uploads", "books", fileName).Replace("\\", "/");
            }

            var book = new Book
            {
                Name = createBook.Name,
                Photo = photoPath,
                AuthorId = createBook.AuthorId,
                desc = createBook.desc,
                StockQty = createBook.StockQty,
                Price = createBook.Price,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            await _context.Books.AddAsync(book);
            await _context.SaveChangesAsync();
            // Handle Discount
            if (createBook.DiscountPercentage.HasValue)
            {
                var discount = new BookDiscount
                {
                    BookId = book.Id,
                    DiscountPercentage = createBook.DiscountPercentage.Value,
                    StartDate = createBook.DiscountStartDate ?? DateTime.UtcNow,
                    EndDate = createBook.DiscountEndDate ?? DateTime.UtcNow.AddDays(7)
                };
                await _context.BookDiscounts.AddAsync(discount);
                await _context.SaveChangesAsync();
                // Refresh discounts collection for the return object
                book.Discounts.Add(discount);
            }
            return book;
        }
    }
}