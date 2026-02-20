using mobile_api.Models;
using mobile_api.Data;
using Microsoft.EntityFrameworkCore;
using mobile_api.Interfaces;
using mobile_api.DTOs.User;
using Microsoft.AspNetCore.Hosting;

namespace mobile_api.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly Database _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public UserRepository(Database context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
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

        public async Task<User> CreateUserAsync(CreateUserDto createUserDto)
        {
            string photoPath = string.Empty;

            if (createUserDto.Photo != null)
            {
                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "profiles");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(createUserDto.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await createUserDto.Photo.CopyToAsync(stream);
                }

                photoPath = Path.Combine("uploads", "profiles", fileName).Replace("\\", "/");
            }

            var user = new User
            {
                Email = createUserDto.Email,
                Password = createUserDto.Password,
                RoleId = createUserDto.RoleId,
                is_active = createUserDto.IsActive,
                created_at = DateTime.UtcNow,
                updated_at = DateTime.UtcNow
            };

            await _context.Users.AddAsync(user);
            await _context.SaveChangesAsync();

            var profile = new UserProfile
            {
                UserId = user.Id,
                Fname = createUserDto.Fname,
                Lname = createUserDto.Lname,
                Phone = createUserDto.Phone,
                Address = createUserDto.Address,
                Dob = createUserDto.Dob,
                Photo = photoPath
            };

            await _context.UserProfiles.AddAsync(profile);
            await _context.SaveChangesAsync();

            user.Profile = profile;
            return user;
        }

        public async Task<User?> UpdateUserAsync(int id, UpdateUserDto updateUserDto)
        {
            var existingUser = await _context.Users
                .Include(u => u.Profile)
                .FirstOrDefaultAsync(u => u.Id == id);

            if (existingUser == null)
            {
                return null;
            }

            if (!string.IsNullOrEmpty(updateUserDto.Email)) existingUser.Email = updateUserDto.Email;
            if (!string.IsNullOrEmpty(updateUserDto.Password)) existingUser.Password = updateUserDto.Password;
            if (updateUserDto.RoleId.HasValue) existingUser.RoleId = updateUserDto.RoleId.Value;
            if (updateUserDto.IsActive.HasValue) existingUser.is_active = updateUserDto.IsActive.Value;
            existingUser.updated_at = DateTime.UtcNow;

            if (existingUser.Profile == null)
            {
                existingUser.Profile = new UserProfile { UserId = existingUser.Id };
                await _context.UserProfiles.AddAsync(existingUser.Profile);
            }

            if (!string.IsNullOrEmpty(updateUserDto.Fname)) existingUser.Profile.Fname = updateUserDto.Fname;
            if (!string.IsNullOrEmpty(updateUserDto.Lname)) existingUser.Profile.Lname = updateUserDto.Lname;
            if (!string.IsNullOrEmpty(updateUserDto.Phone)) existingUser.Profile.Phone = updateUserDto.Phone;
            if (!string.IsNullOrEmpty(updateUserDto.Address)) existingUser.Profile.Address = updateUserDto.Address;
            if (updateUserDto.Dob.HasValue) existingUser.Profile.Dob = updateUserDto.Dob.Value;

            if (updateUserDto.Photo != null)
            {
                if (!string.IsNullOrEmpty(existingUser.Profile.Photo))
                {
                    var oldFilePath = Path.Combine(_webHostEnvironment.WebRootPath, existingUser.Profile.Photo);
                    if (File.Exists(oldFilePath))
                    {
                        File.Delete(oldFilePath);
                    }
                }

                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "profiles");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(updateUserDto.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await updateUserDto.Photo.CopyToAsync(stream);
                }

                existingUser.Profile.Photo = Path.Combine("uploads", "profiles", fileName).Replace("\\", "/");
            }

            await _context.SaveChangesAsync();
            return existingUser;
        }

        public async Task<bool> DeleteUserAsync(int id)
        {
            var user = await _context.Users
                .Include(u => u.Profile)
                .FirstOrDefaultAsync(u => u.Id == id);

            if (user == null)
            {
                return false;
            }

            if (user.Profile != null && !string.IsNullOrEmpty(user.Profile.Photo))
            {
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, user.Profile.Photo);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}