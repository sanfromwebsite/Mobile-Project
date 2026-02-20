using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace mobile_api.DTOs.User
{
    public class UpdateUserDto
    {
        [EmailAddress]
        public string? Email { get; set; }

        public string? Password { get; set; }

        public int? RoleId { get; set; }

        public string? Fname { get; set; }

        public string? Lname { get; set; }

        public string? Phone { get; set; }
        public string? Address { get; set; }
        public DateOnly? Dob { get; set; }
        public IFormFile? Photo { get; set; }
        public int? IsActive { get; set; }
    }
}
