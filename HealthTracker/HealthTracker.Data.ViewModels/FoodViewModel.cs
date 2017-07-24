using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HealthTracker.Data.ViewModels
{
    public class FoodViewModel
    {
        public System.Guid FoodId { get; set; }
        public string FoodName { get; set; }
        public double ServingSize { get; set; }
        public string ServingSizeUnits { get; set; }
        public int Calories { get; set; }
        public int Fat { get; set; }
        public int Carb { get; set; }
        public int Protein { get; set; }
        public Nullable<int> Fiber { get; set; }
    }
}
