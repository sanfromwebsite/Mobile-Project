namespace mobile_api.DTOs.Notification
{
    public class NotificationDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Photo { get; set; } = string.Empty;
        public string Desc { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
