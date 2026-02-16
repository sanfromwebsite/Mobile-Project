using System;
using System.ComponentModel.DataAnnotations;

namespace mobile_api.Models
{
    public class RevokedToken
    {
        [Key]
        public int Id { get; set; }
        public string Token { get; set; } = string.Empty;
        public DateTime ExpiredAt { get; set; }
    }
}
