using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Auth;
using mobile_api.Interfaces;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace mobile_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthRepository _authRepository;
        private readonly IConfiguration _configuration;

        public AuthController(IAuthRepository authRepository, IConfiguration configuration)
        {
            _authRepository = authRepository;
            _configuration = configuration;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromForm] RegisterDto registerDto)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (await _authRepository.UserExists(registerDto.Email))
                return BadRequest(new { result = false, message = "Email already exists" });

            var user = await _authRepository.Register(registerDto);
            var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
            if (user.Profile != null && !string.IsNullOrEmpty(user.Profile.Photo))
            {
                user.Profile.Photo = $"{baseUrl}{user.Profile.Photo}";
            }

            return Ok(new
            {
                result = true,
                message = "Register success",
                data = user
            });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromForm] LoginDto loginDto)
        {
            var user = await _authRepository.Login(loginDto);

            if (user == null)
                return BadRequest(new { result = false, message = "Invalid email or password" });

            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtKey = _configuration["Jwt:Key"] ?? throw new InvalidOperationException("JWT Key is not configured.");
            var key = Encoding.UTF8.GetBytes(jwtKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(ClaimTypes.Role, user.Role != null ? user.Role.Name : "User")
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                Issuer = _configuration["Jwt:Issuer"],
                Audience = _configuration["Jwt:Audience"],
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            var jwtToken = tokenHandler.WriteToken(token);

            var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
            var photoUrl = (user.Profile != null && !string.IsNullOrEmpty(user.Profile.Photo))
                ? $"{baseUrl}{user.Profile.Photo}"
                : null;

            return Ok(new
            {
                result = true,
                message = "Login success",
                token = jwtToken,
                data = new
                {
                    user.Id,
                    user.Email,
                    user.RoleId,
                    profile = user.Profile != null ? new
                    {
                        user.Profile.Fname,
                        user.Profile.Lname,
                        user.Profile.Phone,
                        user.Profile.Address,
                        user.Profile.Dob,
                        Photo = photoUrl
                    } : null
                }
            });
        }

        [HttpPost("logout")]
        public async Task<IActionResult> Logout()
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (string.IsNullOrEmpty(token))
            {
                return BadRequest(new { result = false, message = "Token is required" });
            }
            try
            {
                await _authRepository.Logout(token);
                return Ok(new { result = true, message = "Logout success" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "Logout failed", error = ex.Message });
            }
        }
    }
}