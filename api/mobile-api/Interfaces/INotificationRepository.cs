using mobile_api.Models;
using mobile_api.DTOs.Notification;

namespace mobile_api.Interfaces
{
    public interface INotificationRepository
    {
        Task<List<Notification>> GetAllNotification();
        Task<Notification> CreateNotification(CreateNotificationDto notificationDto);
        Task<bool> DeleteNotification(int id);
        Task<bool> ClearNotifications();
    }
}

