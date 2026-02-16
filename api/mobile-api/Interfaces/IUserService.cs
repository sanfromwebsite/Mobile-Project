using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface IUserService
    {
        Task<List<User>> GetAllUsersAsync();
        Task<User?> GetUserByIdAsync(int id);
        Task<User> CreateUserAsync(User user);
        Task<User?> UpdateUserAsync(int id, User user);
        Task<bool> DeleteUserAsync(int id);
    }
}
