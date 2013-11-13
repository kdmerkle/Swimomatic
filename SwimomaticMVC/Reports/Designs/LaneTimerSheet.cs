using System;
using System.Drawing;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using DataDynamics.ActiveReports;
using DataDynamics.ActiveReports.Document;

namespace SwimomaticMVC.Reports
{
    /// <summary>
    /// Summary description for NewActiveReport1.
    /// </summary>
    public partial class LaneTimerSheet : DataDynamics.ActiveReports.ActiveReport
    {

        #region _ctor
        public LaneTimerSheet()
        {
            InitializeComponent();
        }
        #endregion

        #region Properties
        public int LaneCount { get; set; }
        public string EventDescription { get; set; }
        #endregion

        private void LaneTimerSheet_ReportStart(object sender, EventArgs e)
        {
            detail.ColumnCount = this.LaneCount;
        }

        private void groupHeader1_Format(object sender, EventArgs e)
        {
            lblEvent.Text = this.EventDescription;
        } 
    }
}
