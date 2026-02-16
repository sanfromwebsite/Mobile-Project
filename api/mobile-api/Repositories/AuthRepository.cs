using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Data;
using mobile_api.DTOs.Auth;
using mobile_api.Interfaces;
using mobile_api.Models;
using Microsoft.EntityFrameworkCore;

namespace mobile_api.Repositories
{
    public class AuthRepository : IAuthRepository
    {
        private readonly Database _context;
        public AuthRepository(Database context)
        {
            _context = context;
        }

        public async Task<User> Register(RegisterDto registerDto)
        {
            var user = new User
            {
                Email = registerDto.Email,
                Password = registerDto.Password,
                RoleId = 2,
                is_active = 1,
                created_at = DateTime.UtcNow,
                updated_at = DateTime.UtcNow
            };

            await _context.Users.AddAsync(user);
            await _context.SaveChangesAsync();

            var userProfile = new UserProfile
            {
                UserId = user.Id,
                Fname = registerDto.Fname,
                Lname = registerDto.Lname,
                Phone = registerDto.Phone ?? string.Empty,
                Address = string.Empty,
                Photo = "uploads/profiles/default.png",
                Dob = DateOnly.FromDateTime(DateTime.UtcNow)
            };

            await _context.UserProfiles.AddAsync(userProfile);
            await _context.SaveChangesAsync();

            user.Profile = userProfile;

            return user;
        }

        public async Task<bool> UserExists(string email)
        {
            return await _context.Users.AnyAsync(u => u.Email == email);
        }

        public async Task<User> Login(LoginDto loginDto)
        {
            var user = await _context.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Email == loginDto.Email);
            if (user == null) return null;
            if (user.Password != loginDto.Password) return null;
            return user;
        }

        public async Task<bool> Logout(string token)
        {
            var handler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(token);
            var expiry = jwtToken.ValidTo;
            _context.RevokedTokens.Add(new RevokedToken
            {
                Token = token,
                ExpiredAt = expiry
            });
            await _context.SaveChangesAsync();
            return true;
        }
    }
}