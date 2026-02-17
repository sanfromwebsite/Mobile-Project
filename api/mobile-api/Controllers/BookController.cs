using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Book;
using mobile_api.Interfaces;
using mobile_api.Models;

using mobile_api.Helpers;

namespace mobile_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookController : ControllerBase
    {
        private readonly IBookRepository _bookRepository;
        public BookController(IBookRepository bookRepository)
        {
            _bookRepository = bookRepository;
        }
        /// <summary>
        /// The code is case-insensitive, so price_desc, Price_Desc, and PRICE_DESC will all work perfectly!
        /// </summary>
        /// <remarks>
        /// Use 'SortBy' to sort by fields (e.g., "Name", "Price"). 
        /// Add "_desc" for descending order (e.g., "Price_desc"). 
        /// Sorting is case-insensitive.
        /// </remarks>
        [HttpGet]
        public async Task<ActionResult> GetAllBooks([FromQuery] BookQueryObject query)
        {
            var books = await _bookRepository.GetAllBooks(query);

            var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
            foreach (var book in books)
            {
                if (!string.IsNullOrEmpty(book.Photo) && !book.Photo.StartsWith("http"))
                {
                    book.Photo = $"{baseUrl}{book.Photo}";
                }
            }
            return Ok(new
            {
                result = true,
                message = "Get all book",
                data = books
            });
        }

        [HttpPost]
        public async Task<ActionResult> CreateBook([FromForm] CreateBookDto createBookDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var createdBook = await _bookRepository.CreateBook(createBookDto);

                if (!string.IsNullOrEmpty(createdBook.Photo) && !createdBook.Photo.StartsWith("http"))
                {
                    var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                    createdBook.Photo = $"{baseUrl}{createdBook.Photo}";
                }
                return Ok(new
                {
                    result = true,
                    message = "Create book success",
                    data = createdBook
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while creating the book", error = ex.Message });
            }
        }

        [HttpPost("update/{id:int}")]
        public async Task<ActionResult> UpdateBook(int id, [FromForm] UpdateBookDto updateBookDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var updatedBook = await _bookRepository.UpdateBook(id, updateBookDto);
                if (updatedBook == null) return NotFound(new
                {
                    result = false,
                    message = "Book not found",
                });

                if (!string.IsNullOrEmpty(updatedBook.Photo) && !updatedBook.Photo.StartsWith("http"))
                {
                    var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                    updatedBook.Photo = $"{baseUrl}{updatedBook.Photo}";
                }

                return Ok(new
                {
                    result = true,
                    message = "Update book success",
                    data = updatedBook
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    result = false,
                    message = "An error occurred while updating the book",
                    error = ex.Message
                });
            }
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteBook(int id)
        {
            try
            {
                var book = await _bookRepository.DeleteBook(id);
                if (book == null) return NotFound(new
                {
                    result = false,
                    message = "Book not found",
                });

                return Ok(new
                {
                    result = true,
                    message = "Delete book success"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    result = false,
                    message = "An error occurred while deleting the book",
                    error = ex.Message
                });
            }
        }
    }
}