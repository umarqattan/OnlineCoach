//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HealthTracker.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ExerciseEntry
    {
        public System.Guid ExerciseEntryId { get; set; }
        public System.Guid ExerciseId { get; set; }
        public System.Guid DiaryId { get; set; }
        public int Sets { get; set; }
        public int Reps { get; set; }
        public int Weight { get; set; }
        public bool Complete { get; set; }
    
        public virtual Diary Diary { get; set; }
        public virtual Exercise Exercise { get; set; }
    }
}
