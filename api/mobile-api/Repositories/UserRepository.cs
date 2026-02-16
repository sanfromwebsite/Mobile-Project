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
            return await _context.Users
                .Include(u => u.Role)
                .Include(u => u.Profile)
                .ToListAsync();
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            return await _context.Users
                .Include(u => u.Role)
                .Include(u => u.Profile)
                .FirstOrDefaultAsync(u => u.Id == id);
        }

        public async Task<User> CreateUserAsync(User user)
        {
            user.created_at = DateTime.UtcNow;
            user.updated_at = DateTime.UtcNow;

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return user;
        }

        public async Task<User?> UpdateUserAsync(int id, User user)
        {
            var existingUser = await _context.Users.FindAsync(id);
            if (existingUser == null)
            {
                return null;
            }

            existingUser.Email = user.Email;
            existingUser.Password = user.Password;
            existingUser.RoleId = user.RoleId;
            existingUser.is_active = user.is_active;
            existingUser.updated_at = DateTime.UtcNow;

            await _context.SaveChangesAsync();
            return existingUser;
        }

        public async Task<bool> DeleteUserAsync(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return false;
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return true;
        }

    }
}