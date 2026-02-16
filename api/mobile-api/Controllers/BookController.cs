using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Book;
using mobile_api.Interfaces;
using mobile_api.Models;

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
        [HttpGet]
        public async Task<ActionResult> GetAllBooks()
        {
            var books = await _bookRepository.GetAllBooks();

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
    }
}