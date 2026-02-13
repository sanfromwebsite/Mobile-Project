using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace mobile_api.Models
{
    public class UserProfile
    {
        [Key]
        public int UserId { get; set; }
        public string Fname { get; set; } = string.Empty;
        public string Lname { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public DateOnly Dob { get; set; }
        public string Photo { get; set; } = string.Empty;

        public virtual User User { get; set; } = null!;

    }
}