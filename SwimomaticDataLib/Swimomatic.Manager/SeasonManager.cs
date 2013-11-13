namespace Swimomatic.Manager
{


    public class SeasonManager : _SeasonManager
    {

        #region  Constructor
        public SeasonManager()
        {
        }

        public SeasonManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) :
            base(serviceProvider)
        {
        }
        #endregion

    }
}
