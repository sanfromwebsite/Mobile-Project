using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Author;
using mobile_api.Interfaces;
using mobile_api.Models;

namespace mobile_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthorController : ControllerBase
    {
        private readonly IAuthorRepository _authorRepository;
        public AuthorController(IAuthorRepository authorRepository)
        {
            _authorRepository = authorRepository;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllAuthor()
        {
            try
            {
                var authors = await _authorRepository.GetAllAuthor();

                var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                foreach (var author in authors)
                {
                    if (!string.IsNullOrEmpty(author.Photo) && !author.Photo.StartsWith("http"))
                    {
                        author.Photo = $"{baseUrl}{author.Photo}";
                    }
                }

                return Ok(new
                {
                    result = true,
                    message = "Get all author success",
                    data = authors
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while retrieving the authors", error = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateAuthor([FromForm] CreateAuthorDto createAuthorDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            try
            {
                var createdAuthor = await _authorRepository.CreateAuthor(createAuthorDto);

                if (!string.IsNullOrEmpty(createdAuthor.Photo) && !createdAuthor.Photo.StartsWith("http"))
                {
                    var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                    createdAuthor.Photo = $"{baseUrl}{createdAuthor.Photo}";
                }

                return Ok(new
                {
                    result = true,
                    message = "Create author success",
                    data = createdAuthor
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while creating the author", error = ex.Message });
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAuthor(int id)
        {
            try
            {
                var deletedAuthor = await _authorRepository.DeleteAuthor(id);
                if (!deletedAuthor) return NotFound(new
                {
                    result = false,
                    message = "Author not found"
                });
                return Ok(new
                {
                    result = true,
                    message = "Delete author success"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while deleting the author", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateAuthor(int id, [FromForm] CreateAuthorDto createAuthorDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            try
            {
                var updatedAuthor = await _authorRepository.UpdateAuthor(id, createAuthorDto);
                if (updatedAuthor == null) return NotFound(new
                {
                    result = false,
                    message = "Author not found"
                });

                if (!string.IsNullOrEmpty(updatedAuthor.Photo) && !updatedAuthor.Photo.StartsWith("http"))
                {
                    var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                    updatedAuthor.Photo = $"{baseUrl}{updatedAuthor.Photo}";
                }

                return Ok(new
                {
                    result = true,
                    message = "Update author success",
                    data = updatedAuthor
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while updating the author", error = ex.Message });
            }
        }
    }
}