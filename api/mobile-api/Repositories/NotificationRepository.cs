using Microsoft.EntityFrameworkCore;
using mobile_api.Data;
using mobile_api.Interfaces;
using mobile_api.Models;
using mobile_api.DTOs.Notification;

namespace mobile_api.Repositories
{
    public class NotificationRepository : INotificationRepository
    {
        private readonly Database _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public NotificationRepository(Database context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<List<Notification>> GetAllNotification()
        {
            return await _context.Notifications
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync();
        }

        public async Task<bool> ClearNotifications()
        {
            var notifications = await _context.Notifications.ToListAsync();

            if (!notifications.Any()) return true;

            foreach (var notification in notifications)
            {
                if (!string.IsNullOrEmpty(notification.Photo))
                {
                    var filePath = Path.Combine(_webHostEnvironment.WebRootPath, notification.Photo);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }
                }
            }

            _context.Notifications.RemoveRange(notifications);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<Notification> CreateNotification(CreateNotificationDto notificationDto)
        {
            string photoPath = string.Empty;

            if (notificationDto.Photo != null)
            {
                var folderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "notifications");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(notificationDto.Photo.FileName);
                var filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await notificationDto.Photo.CopyToAsync(stream);
                }

                photoPath = Path.Combine("uploads", "notifications", fileName).Replace("\\", "/");
            }

            var notification = new Notification
            {
                Name = notificationDto.Name,
                Desc = notificationDto.Desc,
                Photo = photoPath,
                CreatedAt = DateTime.UtcNow
            };

            await _context.Notifications.AddAsync(notification);
            await _context.SaveChangesAsync();
            return notification;
        }


        public async Task<bool> DeleteNotification(int id)
        {
            var notification = await _context.Notifications.FindAsync(id);
            if (notification == null) return false;

            if (!string.IsNullOrEmpty(notification.Photo))
            {
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, notification.Photo);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }

            _context.Notifications.Remove(notification);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}


