using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using HealthTracker.Data;
using HealthTracker.Data.Models;
using System.Data.Entity;
using System.Threading.Tasks;
using HealthTracker.Data.ViewModels;
using System.Web.Http.ModelBinding;

namespace HealthTracker.Web.Controllers.API
{
    public class FoodsController : ApiController
    {
        HealthTrackerEntities db = new HealthTrackerEntities();

        // GET: api/Foods
        public async  Task<IEnumerable<FoodViewModel>> Get()
        {
            return await this.db.Foods.Select(x => new FoodViewModel
            {
                Calories = x.Calories,
                Carb = x.Carbs,
                Fat = x.Fat,
                FoodId = x.FoodId, 
                Fiber = x.Fiber,
                FoodName = x.FoodName,
                Protein = x.Protein,
                ServingSize = x.ServingSize,
                ServingSizeUnits = x.ServingSizeUnits
            }).ToListAsync();
        }

        // GET: api/Foods/5
        public async Task<FoodViewModel> Get(string id)
        {
            return await this.db.Foods.Where(x => x.FoodId.ToString() == id).Select(x => new FoodViewModel
            {
                Calories = x.Calories,
                Carb = x.Carbs,
                Fat = x.Fat,
                FoodId = x.FoodId,
                Fiber = x.Fiber,
                FoodName = x.FoodName,
                Protein = x.Protein,
                ServingSize = x.ServingSize,
                ServingSizeUnits = x.ServingSizeUnits
            }).SingleOrDefaultAsync();
        }

        // POST: api/Foods
        public async Task Post([FromBody] FoodViewModel m)
        {
            if (await this.db.Foods.Where(x => x.FoodName.ToLower() == m.FoodName).AnyAsync())
                throw new InvalidOperationException("Food with that name already exists");

            this.db.Foods.Add(new Food
            {
                FoodId = Guid.NewGuid(),
                Calories = m.Calories,
                Carbs = m.Carb,
                Fat = m.Fat,
                Fiber = m.Fiber,
                FoodName = m.FoodName,
                Protein = m.Protein,
                ServingSize = m.ServingSize,
                ServingSizeUnits = m.ServingSizeUnits
            });
            try
            {
                await this.db.SaveChangesAsync();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        // PUT: api/Foods/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Foods/5
        public void Delete(int id)
        {
        }
    }
}
