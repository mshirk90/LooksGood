using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(LooksGood.Startup))]
namespace LooksGood
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
