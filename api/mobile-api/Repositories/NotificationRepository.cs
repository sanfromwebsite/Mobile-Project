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

        public NotificationRepository(Database context)
        {
            _context = context;
        }

        public async Task<List<Notification>> GetNotificationsAsync()
        {
            return await _context.Notifications
                .OrderByDescending(n => n.CreatedAt)
                .ToListAsync();
        }

        public async Task<bool> ClearNotificationsAsync()
        {
            var notifications = await _context.Notifications.ToListAsync();

            if (!notifications.Any()) return true;

            _context.Notifications.RemoveRange(notifications);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<Notification> CreateNotificationAsync(CreateNotificationDto notificationDto)
        {
            var notification = new Notification
            {
                Name = notificationDto.Name,
                Desc = notificationDto.Desc,
                CreatedAt = DateTime.UtcNow
            };

            await _context.Notifications.AddAsync(notification);
            await _context.SaveChangesAsync();
            return notification;
        }
    }
}
