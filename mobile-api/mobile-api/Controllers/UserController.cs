using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mobile_api.Interfaces;

namespace mobile_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpGet("getUser")]
        public async Task<IActionResult> Get()
        {
            var users = await _userRepository.GetAllUser();
            return Ok(users);
        }
    }
}