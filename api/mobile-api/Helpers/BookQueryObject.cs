namespace mobile_api.Helpers
{
    public class BookQueryObject
    {
        public string? Name { get; set; } = null;
        public string? SortBy { get; set; } = null;
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
    }
}
