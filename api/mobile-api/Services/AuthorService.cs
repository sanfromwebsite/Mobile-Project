using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Interfaces;
using mobile_api.Models;

namespace mobile_api.Services
{
    public class AuthorService: IAuthorService 
    {
        private readonly IAuthorRepository _authorRepository;
        public AuthorService(IAuthorRepository authorRepository)
        {
            _authorRepository = authorRepository;
        }

        public async Task<List<Author>> GetAllAuthor()
        {
            return await _authorRepository.GetAllAuthor();
        }
    }
}