using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Reflection;

namespace SwimomaticBusinessLib
{
    public static class Utility
    {
        public static string ConvertIntListToDelimitedString(List<int> intList, string delimiter)
        {
            string[] intArrayStr = Array.ConvertAll<int, string>(intList.ToArray(), new Converter<int, string>(Convert.ToString));
            return String.Join(delimiter, intArrayStr);
        }

        public static string ConvertIntListToDelimitedString(List<int> intList)
        {
            return ConvertIntListToDelimitedString(intList, "|");
        }

        public static string GetTimeFromSeconds(double secs)
        {
            string timeString = "";

            if (secs > 0)
            {
                TimeSpan t = TimeSpan.FromSeconds(secs);
                string sHours = t.Hours > 0 ? t.Hours.ToString() + ":" : "";
                string sMinutes = t.Minutes > 0 ? t.Minutes.ToString() + ":" : "";
                string sSeconds = t.Seconds.ToString("00") + ".";
                string sMilliseconds = (t.Milliseconds > 0) ? Math.Round((double)t.Milliseconds, 2).ToString().Substring(0, 2) : "00";
                timeString = sHours + sMinutes + sSeconds + sMilliseconds;
            }
            return timeString;
        }

        public static List<ListItem> GetListItemsFromLAAFCollection(IEnumerable<LAAF.Core.LAEntity> LAAFCollection, string TextField, string ValueField, string AllText)
        {
            List<ListItem> returnValue = new List<ListItem>();
            ListItem listItem = new ListItem();
            listItem.Text = "<Select>";
            listItem.Value = "-1";
            returnValue.Add(listItem);

            if (AllText.Length > 0)
            {
                listItem = new ListItem();
                listItem.Text = "<All " + AllText + ">";
                listItem.Value = "0";
                returnValue.Add(listItem);
            }

            foreach (LAAF.Core.LAEntity entity in LAAFCollection)
            {
                PropertyInfo[] properties = entity.GetType().GetProperties();
                listItem = new ListItem();
                foreach (PropertyInfo pi in properties)
                {
                    if (pi.Name.Equals(TextField))
                    {
                        listItem.Text = pi.GetValue(entity, null).ToString();
                    }
                    if (pi.Name.Equals(ValueField))
                    {
                        listItem.Value = pi.GetValue(entity, null).ToString();
                    }
                }
                returnValue.Add(listItem);
            }
            return returnValue;
        }
    }

    public class ListItem
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }

}
