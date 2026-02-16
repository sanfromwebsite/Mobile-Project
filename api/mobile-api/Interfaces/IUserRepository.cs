using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface IUserRepository
    {
        Task<List<User>> GetAllUser();
        Task<User?> GetUserByIdAsync(int id);
        Task<User> CreateUserAsync(User user);
        Task<User?> UpdateUserAsync(int id, User user);
        Task<bool> DeleteUserAsync(int id);
    }
}