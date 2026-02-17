using Microsoft.AspNetCore.Mvc;
using mobile_api.Interfaces;
using mobile_api.DTOs.Notification;

namespace mobile_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationRepository _notificationRepo;

        public NotificationController(INotificationRepository notificationRepo)
        {
            _notificationRepo = notificationRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetNotifications()
        {
            var notifications = await _notificationRepo.GetNotificationsAsync();

            var notificationDtos = notifications.Select(n => new NotificationDto
            {
                Id = n.Id,
                Name = n.Name,
                Desc = n.Desc,
                CreatedAt = n.CreatedAt
            });

            return Ok(new { result = true, data = notificationDtos });
        }

        [HttpDelete("clear")]
        public async Task<IActionResult> ClearNotifications()
        {
            await _notificationRepo.ClearNotificationsAsync();
            return Ok(new { result = true, message = "All notifications cleared" });
        }

        [HttpPost]
        public async Task<IActionResult> CreateNotification([FromForm] CreateNotificationDto createDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var notification = await _notificationRepo.CreateNotificationAsync(createDto.Name, createDto.Desc);

            return Ok(new
            {
                result = true,
                message = "Notification created successfully",
                data = new NotificationDto
                {
                    Id = notification.Id,
                    Name = notification.Name,
                    Desc = notification.Desc,
                    CreatedAt = notification.CreatedAt
                }
            });
        }
    }
}
