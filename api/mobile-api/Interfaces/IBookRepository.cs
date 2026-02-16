using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.DTOs.Book;
using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface IBookRepository
    {
        Task<List<Book>> GetAllBooks();
        Task<Book> CreateBook(CreateBookDto createBook);
    }
}