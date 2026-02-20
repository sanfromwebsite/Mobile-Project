using mobile_api.Models;
using mobile_api.DTOs.User;

namespace mobile_api.Interfaces
{
    public interface IUserRepository
    {
        Task<List<User>> GetAllUser();
        Task<User?> GetUserByIdAsync(int id);
        Task<User> CreateUserAsync(CreateUserDto createUserDto);
        Task<User?> UpdateUserAsync(int id, UpdateUserDto updateUserDto);
        Task<bool> DeleteUserAsync(int id);
    }
}