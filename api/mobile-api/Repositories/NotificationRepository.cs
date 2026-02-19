using Microsoft.EntityFrameworkCore;
using mobile_api.Data;
using mobile_api.Interfaces;
using mobile_api.Models;

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

        public async Task<Notification> CreateNotificationAsync(string name, string desc)
        {
            var notification = new Notification
            {
                Name = name,
                Desc = desc,
                CreatedAt = DateTime.UtcNow
            };

            await _context.Notifications.AddAsync(notification);
            await _context.SaveChangesAsync();
            return notification;
        }
    }
}
