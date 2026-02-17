using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.DTOs.Book;
using mobile_api.Models;
using mobile_api.Helpers;

namespace mobile_api.Interfaces
{
    public interface IBookRepository
    {
        Task<List<Book>> GetAllBooks(BookQueryObject query);
        Task<Book> CreateBook(CreateBookDto createBook);
        Task<Book?> UpdateBook(int id, UpdateBookDto updateBookDto);
        Task<Book> DeleteBook(int id);
    }
}