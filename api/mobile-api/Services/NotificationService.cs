using mobile_api.Interfaces;
using mobile_api.Models;
using mobile_api.DTOs.Notification;

namespace mobile_api.Services
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _notificationRepository;

        public NotificationService(INotificationRepository notificationRepository)
        {
            _notificationRepository = notificationRepository;
        }

        public async Task<List<Notification>> GetAllNotification()
        {
            return await _notificationRepository.GetAllNotification();
        }
    }
}
