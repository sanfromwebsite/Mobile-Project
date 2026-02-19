using mobile_api.Models;
using mobile_api.DTOs.Notification;

namespace mobile_api.Interfaces
{
    public interface INotificationRepository
    {
        Task<List<Notification>> GetNotificationsAsync();
        Task<bool> ClearNotificationsAsync();
        Task<Notification> CreateNotificationAsync(CreateNotificationDto notificationDto);
    }
}
