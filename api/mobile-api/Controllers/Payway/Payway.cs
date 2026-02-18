using Microsoft.AspNetCore.Mvc;
using mobile_api.Models.Payway;
using mobile_api.Services;

namespace mobile_api.Controllers.Payway
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaywayController : ControllerBase
    {
        private readonly PaywayServices _paywayService;

        public PaywayController(PaywayServices paywayService)
        {
            _paywayService = paywayService;
        }

        [HttpPost("generate")]
        public IActionResult Generate([FromBody] PaymentRequest request)
        {
            try
            {
                var result = _paywayService.GenerateKHQR(
                    request.Amount,
                    request.BillNumber,
                    request.MobileNumber
                );

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    error = "KHQR_GENERATION_FAILED",
                    message = ex.Message
                });
            }
        }

        [HttpGet("check-by-md5/{md5}")]
        public async Task<IActionResult> CheckPaymentByMd5(string md5)
        {
            try
            {
                var result = await _paywayService.CheckPaymentByMd5Async(md5);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    error = "PAYMENT_CHECK_FAILED",
                    message = ex.Message
                });
            }
        }

    }
}