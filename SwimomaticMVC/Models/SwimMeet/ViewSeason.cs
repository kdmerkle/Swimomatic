using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace SwimomaticMVC.Models
{
    public class ViewSeason
    {
        public int SeasonID { get; set; }
        public int TeamSeasonID { get; set; }
        public int LeagueID { get; set; }
        public string LeagueName { get; set; }
        public string LeagueDescription { get; set; }
        public bool IsAdmin { get; set; }

        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string Description { get; set; }


        public int AgeClassRuleID { get; set; }

        [AgeClassRuleCustomDateRequired("AgeClassRuleID")]
        public DateTime? AgeClassRuleCustomDate { get; set; }
        public SelectList AgeClassRules { get; set; }
        public string AgeClassRuleDescription { get; set; }

        private List<int> _ScoringSchemeIDs;
        public List<int> ScoringSchemeIDs
        {
            get
            {
                if (_ScoringSchemeIDs == null)
                {
                    _ScoringSchemeIDs = new List<int>();
                }
                return _ScoringSchemeIDs;
            }
            set { _ScoringSchemeIDs = value; }
        }

        [Required(ErrorMessage = "Dual/Triangle Individual Points are Required (ex. 5,3,2,1)")]
        [RegularExpression("^([0-9]+,?)+$", ErrorMessage = "Points must be a list of numbers(ex. 5,3,2,1)")]
        public string ScoringCustomIndividual { get; set; }
        [Required(ErrorMessage = "Dual/Triangle Relay Points are Required (ex. 10,6,4,2)")]
        [RegularExpression("^([0-9]+,?)+$", ErrorMessage = "Points must be a list of numbers(ex. 5,3,2,1)")]
        public string ScoringCustomRelay { get; set; }
        [Required(ErrorMessage = "Championship/Invitational Individual Points are Required (ex. 6,4,3,2)")]
        [RegularExpression("^([0-9]+,?)+$", ErrorMessage = "Points must be a list of numbers(ex. 5,3,2,1)")]
        public string ScoringFinalCustomIndividual { get; set; }
        [Required(ErrorMessage = "Championship/Invitational Relay Points are Required (ex. 12,8,6,2)")]
        [RegularExpression("^([0-9]+,?)+$", ErrorMessage = "Points must be a list of numbers(ex. 5,3,2,1)")]
        public string ScoringFinalCustomRelay { get; set; }

        public List<ViewScoringScheme> ScoringUSASchemesHeat { get; set; }
        public List<ViewScoringScheme> ScoringUSASchemesFinal { get; set; }
        public List<ViewScoringScheme> ScoringUSASchemesConsolation { get; set; }

    }

    /// <summary>
    /// Custom validation class
    /// If the argument is true, the property requires a value
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
    sealed public class AgeClassRuleCustomDateRequired : ValidationAttribute
    {
        private string _basePropertyName;
        private const string _defaultErrorMessage = "Custom Date is required.";
        public AgeClassRuleCustomDateRequired(string basePropertyName)
            : base(_defaultErrorMessage)
        {
            _basePropertyName = basePropertyName;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            //Get PropertyInfo Object  
            var basePropertyInfo = validationContext.ObjectType.GetProperty(_basePropertyName);

            //Get Value of the AgeClassRuleID Property 
            var ageClassRuleID = (int)basePropertyInfo.GetValue(validationContext.ObjectInstance, null);

            //Get Value of the AgeClassRuleCustomDate Property
            var ageClassRuleCustomDate = (DateTime?)value;

            //Actual comparision  
            if (ageClassRuleID == 1 && !ageClassRuleCustomDate.HasValue)
            {
                var message = FormatErrorMessage(validationContext.DisplayName);
                return new ValidationResult(message);
            }

            //Default return - This means there were no validation error  
            return null;
        }

        public override string FormatErrorMessage(string name)
        {
            return String.Format(System.Globalization.CultureInfo.CurrentCulture,
              "Custom Date is required.", name);
        }
    }
}