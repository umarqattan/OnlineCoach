namespace HealthTracker.Data.Models.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AcountDeleted : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "AccountDeleted", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.AspNetUsers", "AccountDeleted");
        }
    }
}
