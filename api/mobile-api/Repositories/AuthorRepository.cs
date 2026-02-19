using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using mobile_api.Interfaces;
using mobile_api.Models;
using mobile_api.Data;
using mobile_api.DTOs.Author;
using mobile_api.DTOs.Auth;

namespace mobile_api.Repositories
{
    public class AuthorRepository : IAuthorRepository
    {
        private readonly Database _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public AuthorRepository(Database context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<List<Author>> GetAllAuthor()
        {
            return await _context.Authors.ToListAsync();
        }

        public async Task<Author> CreateAuthor(CreateAuthorDto authorDto)
        {
            string photoPath = string.Empty;

            if (authorDto.Photo != null)
            {
                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "authors");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(authorDto.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await authorDto.Photo.CopyToAsync(stream);
                }

                photoPath = Path.Combine("uploads", "authors", fileName).Replace("\\", "/");
            }

            var author = new Author
            {
                Name = authorDto.Name,
                Photo = photoPath
            };
            _context.Authors.Add(author);
            await _context.SaveChangesAsync();
            return author;
        }

        public async Task<bool> DeleteAuthor(int id)
        {

            var author = await _context.Authors.FindAsync(id);
            if (author == null) return false;

            if (!string.IsNullOrEmpty(author.Photo))
            {
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, author.Photo);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }

            _context.Authors.Remove(author);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<Author?> UpdateAuthor(int id, CreateAuthorDto authorDto)
        {
            var author = await _context.Authors.FindAsync(id);
            if (author == null) return null;

            author.Name = authorDto.Name;

            if (authorDto.Photo != null)
            {
                if (!string.IsNullOrEmpty(author.Photo))
                {
                    var oldFilePath = Path.Combine(_webHostEnvironment.WebRootPath, author.Photo);
                    if (File.Exists(oldFilePath))
                    {
                        File.Delete(oldFilePath);
                    }
                }

                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "authors");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(authorDto.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await authorDto.Photo.CopyToAsync(stream);
                }

                author.Photo = Path.Combine("uploads", "authors", fileName).Replace("\\", "/");
            }

            await _context.SaveChangesAsync();
            return author;
        }

        public async Task<User> Register(RegisterDto registerDto)
        {
            var user = new User
            {
                Email = registerDto.Email,
                Password = registerDto.Password,
                RoleId = 2,
                is_active = 1,
                created_at = DateTime.Now,
                updated_at = DateTime.Now
            };
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var UserProfile = new UserProfile
            {
                Fname = registerDto.Fname,
                Lname = registerDto.Lname,
                Phone = registerDto.Phone,
                Address = "",
                Dob = DateOnly.FromDateTime(DateTime.Now),
                Photo = "",
                UserId = user.Id
            };
            _context.UserProfiles.Add(UserProfile);
            await _context.SaveChangesAsync();

            return user;
        }
    }
}