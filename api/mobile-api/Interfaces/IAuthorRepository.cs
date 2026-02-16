using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Models;
using mobile_api.DTOs.Author;

namespace mobile_api.Interfaces
{
    public interface IAuthorRepository
    {
        Task<List<Author>> GetAllAuthor();
        Task<Author> CreateAuthor(CreateAuthorDto author);
        Task<bool> DeleteAuthor(int id);
        Task<Author?> UpdateAuthor(int id, CreateAuthorDto authorDto);
    }
}