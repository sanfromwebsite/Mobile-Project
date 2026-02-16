using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace mobile_api.Migrations
{
    /// <inheritdoc />
    public partial class RemovePhoto : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Photo",
                table: "Authors");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Photo",
                table: "Authors",
                type: "text",
                nullable: false,
                defaultValue: "");
        }
    }
}
