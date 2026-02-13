using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Models;
using mobile_api.Data;
using Microsoft.EntityFrameworkCore;
using mobile_api.Interfaces;

namespace mobile_api.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly Database _context;
        public UserRepository(Database context)
        {
            _context = context;
        }

        public async Task<List<User>> GetAllUser()
        {
            return await _context.Users.ToListAsync();
        }

    }
}