using Microsoft.AspNetCore.Mvc;
using mobile_api.Interfaces;
using mobile_api.DTOs.User;

namespace mobile_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllUsers()
        {
            try
            {
                var users = await _userService.GetAllUsersAsync();
                var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";

                var userDtos = users.Select(u => new UserDto
                {
                    Id = u.Id,
                    Email = u.Email,
                    RoleId = u.RoleId,
                    RoleName = u.Role?.Name ?? "",
                    IsActive = u.is_active,
                    CreatedAt = u.created_at,
                    Profile = u.Profile == null ? null : new UserProfileDto
                    {
                        Fname = u.Profile.Fname,
                        Lname = u.Profile.Lname,
                        Phone = u.Profile.Phone,
                        Address = u.Profile.Address,
                        Dob = u.Profile.Dob,
                        Photo = string.IsNullOrEmpty(u.Profile.Photo) ? "" : (u.Profile.Photo.StartsWith("http") ? u.Profile.Photo : $"{baseUrl}{u.Profile.Photo}")
                    }
                });

                return Ok(new
                {
                    result = true,
                    message = "Get all users success",
                    data = userDtos
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while retrieving users", error = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            try
            {
                var user = await _userService.GetUserByIdAsync(id);
                if (user == null) return NotFound(new { result = false, message = "User not found" });

                var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                var userDto = new UserDto
                {
                    Id = user.Id,
                    Email = user.Email,
                    RoleId = user.RoleId,
                    RoleName = user.Role?.Name ?? "",
                    IsActive = user.is_active,
                    CreatedAt = user.created_at,
                    Profile = user.Profile == null ? null : new UserProfileDto
                    {
                        Fname = user.Profile.Fname,
                        Lname = user.Profile.Lname,
                        Phone = user.Profile.Phone,
                        Address = user.Profile.Address,
                        Dob = user.Profile.Dob,
                        Photo = string.IsNullOrEmpty(user.Profile.Photo) ? "" : (user.Profile.Photo.StartsWith("http") ? user.Profile.Photo : $"{baseUrl}{user.Profile.Photo}")
                    }
                };

                return Ok(new { result = true, message = "Get user success", data = userDto });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while retrieving the user", error = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser([FromForm] CreateUserDto createUserDto)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            try
            {
                var user = await _userService.CreateUserAsync(createUserDto);
                return Ok(new { result = true, message = "Create user success" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while creating the user", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUser(int id, [FromForm] UpdateUserDto updateUserDto)
        {
            try
            {
                var user = await _userService.UpdateUserAsync(id, updateUserDto);
                if (user == null) return NotFound(new { result = false, message = "User not found" });

                return Ok(new { result = true, message = "Update user success" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while updating the user", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            try
            {
                var deleted = await _userService.DeleteUserAsync(id);
                if (!deleted) return NotFound(new { result = false, message = "User not found" });

                return Ok(new { result = true, message = "Delete user success" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { result = false, message = "An error occurred while deleting the user", error = ex.Message });
            }
        }
    }
}