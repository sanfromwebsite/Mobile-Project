using Microsoft.AspNetCore.Mvc;
using mobile_api.Interfaces;
using mobile_api.DTOs.Notification;
using mobile_api.Models;

namespace mobile_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationRepository _notificationRepo;

        public NotificationController(INotificationRepository notificationRepo)
        {
            _notificationRepo = notificationRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllNotification()
        {
            try
            {
                var notifications = await _notificationRepo.GetAllNotification();
                var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";

                var notificationDtos = notifications.Select(n => new NotificationDto
                {
                    Id = n.Id,
                    Name = n.Name,
                    Desc = n.Desc,
                    Photo = string.IsNullOrEmpty(n.Photo) ? "" : (n.Photo.StartsWith("http") ? n.Photo : $"{baseUrl}{n.Photo}"),
                    CreatedAt = n.CreatedAt
                });

                return Ok(new
                {
                    result = true,
                    message = "Get all notification success",
                    data = notificationDtos
                });

            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while retrieving the notifications", error = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateNotification([FromForm] CreateNotificationDto createDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var notification = await _notificationRepo.CreateNotification(createDto);

                if (!string.IsNullOrEmpty(notification.Photo) && !notification.Photo.StartsWith("http"))
                {
                    var baseUrl = $"{Request.Scheme}://{Request.Host.Value}/";
                    notification.Photo = $"{baseUrl}{notification.Photo}";
                }

                return Ok(new
                {
                    result = true,
                    message = "Create notification success",
                    data = notification
                });
            }

            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while creating the notification", error = ex.Message });
            }
        }

        [HttpDelete("clear")]
        public async Task<IActionResult> ClearNotifications()
        {
            try
            {
                await _notificationRepo.ClearNotifications();
                return Ok(new
                {
                    result = true,
                    message = "Clear all notification success"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while clearing the notifications", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNotification(int id)
        {
            try
            {
                var deleted = await _notificationRepo.DeleteNotification(id);
                if (!deleted) return NotFound(new
                {
                    result = false,
                    message = "Notification not found"
                });

                return Ok(new
                {
                    result = true,
                    message = "Delete notification success"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while deleting the notification", error = ex.Message });
            }
        }
    }
}

