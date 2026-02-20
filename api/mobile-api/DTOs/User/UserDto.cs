using System;

namespace mobile_api.DTOs.User
{
    public class UserDto
    {
        public int Id { get; set; }
        public string Email { get; set; } = string.Empty;
        public int RoleId { get; set; }
        public string RoleName { get; set; } = string.Empty;
        public int IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
        public UserProfileDto? Profile { get; set; }
    }

    public class UserProfileDto
    {
        public string Fname { get; set; } = string.Empty;
        public string Lname { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public DateOnly Dob { get; set; }
        public string Photo { get; set; } = string.Empty;
    }
}
