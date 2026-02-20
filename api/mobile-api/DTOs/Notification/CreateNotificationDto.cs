using Microsoft.AspNetCore.Http;

namespace mobile_api.DTOs.Notification
{
    public class CreateNotificationDto
    {
        public string Name { get; set; } = string.Empty;
        public string Desc { get; set; } = string.Empty;
        public IFormFile? Photo { get; set; }
    }
}


