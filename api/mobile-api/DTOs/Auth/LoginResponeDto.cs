using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mobile_api.Models;

namespace mobile_api.DTOs.Auth
{
    public class LoginResponeDto
    {
        public string Token { get; set; }
        public string Email { get; set; }
        public int UserId { get; set; }
        public int IsActive { get; set; }
    }
}