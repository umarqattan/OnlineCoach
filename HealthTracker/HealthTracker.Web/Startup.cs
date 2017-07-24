using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(HealthTracker.Web.Startup))]
namespace HealthTracker.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
