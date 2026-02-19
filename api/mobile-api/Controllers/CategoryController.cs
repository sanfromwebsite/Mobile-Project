using Microsoft.AspNetCore.Mvc;
using mobile_api.DTOs.Category;
using mobile_api.Interfaces;
using mobile_api.Models;

namespace mobile_api.Controllers
{
    [Route("api/category")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryRepository _categoryRepo;

        public CategoryController(ICategoryRepository categoryRepo)
        {
            _categoryRepo = categoryRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var categories = await _categoryRepo.GetAllAsync();

            var categoryDto = categories.Select(s => new CategoryDto
            {
                Id = s.Id,
                Name = s.Name
            });

            return Ok(new { result = true, data = categoryDto });
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromForm] CreateCategoryDto categoryDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var categoryModel = new Category
            {
                Name = categoryDto.Name
            };

            await _categoryRepo.CreateAsync(categoryModel);

            return Ok(new
            {
                result = true,
                message = "Category created successfully",
            });
        }

        [HttpPut]
        [Route("{id:int}")]
        public async Task<IActionResult> Update([FromRoute] int id, [FromForm] UpdateCategoryDto updateDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var categoryModel = await _categoryRepo.UpdateAsync(id, updateDto);

            if (categoryModel == null)
            {
                return NotFound(new { result = false, message = "Category not found" });
            }

            return Ok(new
            {
                result = true,
                message = "Category updated successfully",
                data = new CategoryDto
                {
                    Id = categoryModel.Id,
                    Name = categoryModel.Name
                }
            });
        }

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var categoryModel = await _categoryRepo.DeleteAsync(id);

            if (categoryModel == null)
            {
                return NotFound(new { result = false, message = "Category not found" });
            }

            return Ok(new { result = true, message = "Category deleted successfully" });
        }
    }
}
