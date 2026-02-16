using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace mobile_api.DTOs.Auth
{
    public class RegisterDto
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required, MinLength(6)]
        public string Password { get; set; }
        [Required, Compare("Password", ErrorMessage = "Passwords do not match")]
        public string ConfirmPassword { get; set; }
        [Required, MaxLength(50)]
        public string Fname { get; set; }
        [Required, MaxLength(50)]
        public string Lname { get; set; }
        [MaxLength(20)]
        public string? Phone { get; set; }
    }
}