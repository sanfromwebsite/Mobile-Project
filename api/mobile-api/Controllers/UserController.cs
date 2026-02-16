using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mobile_api.Interfaces;
using mobile_api.Models;

namespace mobile_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpGet("getUser")]
        [ProducesResponseType(typeof(List<User>), 200)]
        public async Task<IActionResult> GetAllUsers()
        {
            try
            {
                var users = await _userRepository.GetAllUser();
                var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                foreach (var user in users)
                {
                    if (user.Profile != null && !string.IsNullOrEmpty(user.Profile.Photo))
                    {
                        if (!user.Profile.Photo.StartsWith("http"))
                        {
                            user.Profile.Photo = $"{baseUrl}{user.Profile.Photo}";
                        }
                    }
                }
                return Ok(users);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while retrieving users", error = ex.Message });
            }
        }
    }
}