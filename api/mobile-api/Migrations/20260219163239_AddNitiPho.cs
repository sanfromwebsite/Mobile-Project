using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace mobile_api.Migrations
{
    /// <inheritdoc />
    public partial class AddNitiPho : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Photo",
                table: "Notifications",
                type: "text",
                nullable: false,
                defaultValue: "");

            // migrationBuilder.AddColumn<string>(
            //     name: "Photo",
            //     table: "Authors",
            //     type: "text",
            //     nullable: false,
            //     defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Photo",
                table: "Notifications");

            // migrationBuilder.DropColumn(
            //     name: "Photo",
            //     table: "Authors");
        }

    }
}
