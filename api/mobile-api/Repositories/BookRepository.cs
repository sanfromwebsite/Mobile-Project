using mobile_api.Data;
using mobile_api.Models;
using Microsoft.EntityFrameworkCore;

using mobile_api.Interfaces;
using mobile_api.DTOs.Book;

using mobile_api.Helpers;

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

        public async Task<List<Book>> GetAllBooks(BookQueryObject query)
        {
            var books = _context.Books
                .Include(b => b.Discounts)
                .Include(b => b.Author)
                .Include(b => b.Category) // Include single category
                .Include(b => b.BookCategories)
                    .ThenInclude(bc => bc.Category)
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(query.Name))
            {
                books = books.Where(s => s.Name.Contains(query.Name));
            }

            if (!string.IsNullOrWhiteSpace(query.SortBy))
            {
                var sortBy = query.SortBy.ToLower();
                var isDesc = sortBy.EndsWith("_desc");
                var field = isDesc ? sortBy.Replace("_desc", "") : sortBy;

                if (field == "name")
                {
                    books = isDesc ? books.OrderByDescending(s => s.Name) : books.OrderBy(s => s.Name);
                }
                else if (field == "price")
                {
                    books = isDesc ? books.OrderByDescending(s => s.Price) : books.OrderBy(s => s.Price);
                }
            }

            var skipNumber = (query.PageNumber - 1) * query.PageSize;

            return await books.Skip(skipNumber).Take(query.PageSize).ToListAsync();
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
                CategoryId = createBook.CategoryId, // Store single category
                desc = createBook.desc,
                StockQty = createBook.StockQty,
                Price = createBook.Price,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            await _context.Books.AddAsync(book);
            await _context.SaveChangesAsync();

            if (createBook.DiscountPercentage.HasValue)
            {
                var discount = new BookDiscount
                {
                    BookId = book.Id,
                    DiscountPercentage = createBook.DiscountPercentage.Value,
                    StartDate = createBook.DiscountStartDate?.ToUniversalTime() ?? DateTime.UtcNow,
                    EndDate = createBook.DiscountEndDate?.ToUniversalTime() ?? DateTime.UtcNow.AddDays(7)
                };
                await _context.BookDiscounts.AddAsync(discount);
                await _context.SaveChangesAsync();
                book.Discounts.Add(discount);
            }
            return book;
        }

        public async Task<Book?> UpdateBook(int id, UpdateBookDto updateBook)
        {
            var book = await _context.Books.Include(b => b.Discounts).FirstOrDefaultAsync(b => b.Id == id);
            if (book == null)
            {
                return null;
            }

            if (updateBook.Name != null) book.Name = updateBook.Name;
            if (updateBook.AuthorId.HasValue) book.AuthorId = updateBook.AuthorId.Value;
            if (updateBook.CategoryId.HasValue) book.CategoryId = updateBook.CategoryId.Value; // Update single category
            if (updateBook.desc != null) book.desc = updateBook.desc;
            if (updateBook.StockQty.HasValue) book.StockQty = updateBook.StockQty.Value;
            if (updateBook.Price.HasValue) book.Price = updateBook.Price.Value;

            book.UpdatedAt = DateTime.UtcNow;

            if (updateBook.Photo != null)
            {
                if (!string.IsNullOrEmpty(book.Photo))
                {
                    var oldFilePath = Path.Combine(_webHostEnvironment.WebRootPath, book.Photo);
                    if (File.Exists(oldFilePath))
                    {
                        File.Delete(oldFilePath);
                    }
                }

                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "books");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(updateBook.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await updateBook.Photo.CopyToAsync(stream);
                }

                book.Photo = Path.Combine("uploads", "books", fileName).Replace("\\", "/");
            }


            if (updateBook.DiscountPercentage.HasValue)
            {
                var discount = book.Discounts.FirstOrDefault();
                if (discount == null)
                {
                    discount = new BookDiscount
                    {
                        BookId = book.Id,
                        DiscountPercentage = updateBook.DiscountPercentage.Value,
                        StartDate = updateBook.DiscountStartDate?.ToUniversalTime() ?? DateTime.UtcNow,
                        EndDate = updateBook.DiscountEndDate?.ToUniversalTime() ?? DateTime.UtcNow.AddDays(7)
                    };
                    await _context.BookDiscounts.AddAsync(discount);
                }
                else
                {
                    discount.DiscountPercentage = updateBook.DiscountPercentage.Value;
                    discount.StartDate = updateBook.DiscountStartDate?.ToUniversalTime() ?? discount.StartDate;
                    discount.EndDate = updateBook.DiscountEndDate?.ToUniversalTime() ?? discount.EndDate;
                }
            }

            await _context.SaveChangesAsync();
            return book;
        }

        public async Task<Book> DeleteBook(int id)
        {
            var book = await _context.Books.Include(b => b.Discounts).FirstOrDefaultAsync(b => b.Id == id);
            if (book == null)
            {
                return null;
            }

            if (!string.IsNullOrEmpty(book.Photo))
            {
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, book.Photo);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }
            _context.Books.Remove(book);
            await _context.SaveChangesAsync();
            return book;
        }
    }
}