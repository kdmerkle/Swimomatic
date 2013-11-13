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
    public partial class LaneTimerSheetByLane : DataDynamics.ActiveReports.ActiveReport
    {

        public LaneTimerSheetByLane()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
        }

        private void LaneTimerSheetByLane_ReportStart(object sender, EventArgs e)
        {

        }
    }
}
