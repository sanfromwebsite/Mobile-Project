using mobile_api.Models;
using mobile_api.DTOs.Notification;

namespace mobile_api.Interfaces
{
    public interface INotificationService
    {
        Task<List<Notification>> GetAllNotification();
    }
}
