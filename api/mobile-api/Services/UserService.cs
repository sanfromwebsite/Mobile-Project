using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Interfaces;
using mobile_api.Models;

namespace mobile_api.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }
        public async Task<List<User>> GetAllUsersAsync()
        {
            // Business logic can be added here:
            // - Filtering inactive users
            // - Sorting
            // - Logging
            // - Caching

            var users = await _userRepository.GetAllUser();

            // Example: Filter out inactive users (optional)
            // users = users.Where(u => u.is_active == 1).ToList();

            return users;
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            // Business validation
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            return await _userRepository.GetUserByIdAsync(id);
        }
        public async Task<User> CreateUserAsync(User user)
        {
            // Business validation
            if (string.IsNullOrWhiteSpace(user.Email))
            {
                throw new ArgumentException("Email is required", nameof(user.Email));
            }

            if (string.IsNullOrWhiteSpace(user.Password))
            {
                throw new ArgumentException("Password is required", nameof(user.Password));
            }

            // Business rules
            // TODO: Check if email already exists
            // TODO: Hash password before saving
            // TODO: Set default role if not provided
            if (user.RoleId == 0)
            {
                user.RoleId = 2; // Default to "User" role
            }

            return await _userRepository.CreateUserAsync(user);
        }

        public async Task<User?> UpdateUserAsync(int id, User user)
        {
            // Business validation
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            var existingUser = await _userRepository.GetUserByIdAsync(id);
            if (existingUser == null)
            {
                return null;
            }

            // Business rules
            // TODO: Validate email format
            // TODO: Check if new email is already taken by another user
            // TODO: Hash password if it's being changed

            return await _userRepository.UpdateUserAsync(id, user);
        }
        public async Task<bool> DeleteUserAsync(int id)
        {
            // Business validation
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            var user = await _userRepository.GetUserByIdAsync(id);
            if (user == null)
            {
                return false;
            }

            // Business rules
            // TODO: Check if user has active orders
            // TODO: Soft delete instead of hard delete
            // TODO: Log the deletion

            return await _userRepository.DeleteUserAsync(id);
        }
    }
}
