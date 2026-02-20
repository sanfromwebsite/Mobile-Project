using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Interfaces;
using mobile_api.Models;
using mobile_api.DTOs.User;

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
            return await _userRepository.GetAllUser();
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            return await _userRepository.GetUserByIdAsync(id);
        }

        public async Task<User> CreateUserAsync(CreateUserDto createUserDto)
        {
            if (string.IsNullOrWhiteSpace(createUserDto.Email))
            {
                throw new ArgumentException("Email is required", nameof(createUserDto.Email));
            }

            if (string.IsNullOrWhiteSpace(createUserDto.Password))
            {
                throw new ArgumentException("Password is required", nameof(createUserDto.Password));
            }

            if (createUserDto.Password != createUserDto.ConfirmPassword)
            {
                throw new ArgumentException("Passwords do not match");
            }

            return await _userRepository.CreateUserAsync(createUserDto);
        }

        public async Task<User?> UpdateUserAsync(int id, UpdateUserDto updateUserDto)
        {
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            return await _userRepository.UpdateUserAsync(id, updateUserDto);
        }

        public async Task<bool> DeleteUserAsync(int id)
        {
            if (id <= 0)
            {
                throw new ArgumentException("User ID must be greater than 0", nameof(id));
            }

            return await _userRepository.DeleteUserAsync(id);
        }
    }
}
