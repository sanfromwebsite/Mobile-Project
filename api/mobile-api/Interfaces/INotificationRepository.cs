using mobile_api.Models;

namespace mobile_api.Interfaces
{
    public interface INotificationRepository
    {
        Task<List<Notification>> GetNotificationsAsync();
        Task<bool> ClearNotificationsAsync();
        Task<Notification> CreateNotificationAsync(string name, string desc);
    }
}
