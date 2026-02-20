using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace mobile_api.DTOs.User
{
    public class CreateUserDto
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Required]
        [MinLength(6)]
        public string Password { get; set; } = string.Empty;

        [Required]
        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string ConfirmPassword { get; set; } = string.Empty;

        public int RoleId { get; set; } = 2; // Default to User

        [Required]
        public string Fname { get; set; } = string.Empty;

        [Required]
        public string Lname { get; set; } = string.Empty;

        public string Phone { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public DateOnly Dob { get; set; }
        public IFormFile? Photo { get; set; }
        public int IsActive { get; set; } = 1;
    }
}
