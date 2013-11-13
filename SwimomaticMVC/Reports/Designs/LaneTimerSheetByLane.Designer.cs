namespace SwimomaticMVC.Reports
{
    /// <summary>
    /// Summary description for NewActiveReport1.
    /// </summary>
    partial class LaneTimerSheetByLane
    {
        private DataDynamics.ActiveReports.PageHeader pageHeader;
        private DataDynamics.ActiveReports.Detail detail;
        private DataDynamics.ActiveReports.PageFooter pageFooter;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
            }
            base.Dispose(disposing);
        }

        #region ActiveReport Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(LaneTimerSheetByLane));
            this.pageHeader = new DataDynamics.ActiveReports.PageHeader();
            this.txtEventDescription = new DataDynamics.ActiveReports.TextBox();
            this.detail = new DataDynamics.ActiveReports.Detail();
            this.label1 = new DataDynamics.ActiveReports.Label();
            this.txtLaneNumber = new DataDynamics.ActiveReports.TextBox();
            this.label2 = new DataDynamics.ActiveReports.Label();
            this.txtHeatNumber = new DataDynamics.ActiveReports.TextBox();
            this.txtTeamName = new DataDynamics.ActiveReports.TextBox();
            this.txtSwimmerName = new DataDynamics.ActiveReports.TextBox();
            this.line3 = new DataDynamics.ActiveReports.Line();
            this.line1 = new DataDynamics.ActiveReports.Line();
            this.line2 = new DataDynamics.ActiveReports.Line();
            this.line4 = new DataDynamics.ActiveReports.Line();
            this.txtSeedTime = new DataDynamics.ActiveReports.TextBox();
            this.pageFooter = new DataDynamics.ActiveReports.PageFooter();
            ((System.ComponentModel.ISupportInitialize)(this.txtEventDescription)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLaneNumber)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHeatNumber)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTeamName)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSwimmerName)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSeedTime)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeader
            // 
            this.pageHeader.Controls.AddRange(new DataDynamics.ActiveReports.ARControl[] {
            this.txtEventDescription});
            this.pageHeader.Height = 0.5208334F;
            this.pageHeader.Name = "pageHeader";
            // 
            // txtEventDescription
            // 
            this.txtEventDescription.DataField = "EventDescription";
            this.txtEventDescription.Height = 0.2F;
            this.txtEventDescription.Left = 0F;
            this.txtEventDescription.Name = "txtEventDescription";
            this.txtEventDescription.Style = "font-weight: bold; text-decoration: underline";
            this.txtEventDescription.Text = "txtEventDescription";
            this.txtEventDescription.Top = 0F;
            this.txtEventDescription.Width = 5.74F;
            // 
            // detail
            // 
            this.detail.ColumnSpacing = 0F;
            this.detail.Controls.AddRange(new DataDynamics.ActiveReports.ARControl[] {
            this.label1,
            this.txtLaneNumber,
            this.label2,
            this.txtHeatNumber,
            this.txtTeamName,
            this.txtSwimmerName,
            this.line3,
            this.line1,
            this.line2,
            this.line4,
            this.txtSeedTime});
            this.detail.Height = 0.625F;
            this.detail.Name = "detail";
            // 
            // label1
            // 
            this.label1.Height = 0.2F;
            this.label1.HyperLink = null;
            this.label1.Left = 0F;
            this.label1.Name = "label1";
            this.label1.Style = "";
            this.label1.Text = "Lane";
            this.label1.Top = 0F;
            this.label1.Width = 0.354F;
            // 
            // txtLaneNumber
            // 
            this.txtLaneNumber.DataField = "LaneNumber";
            this.txtLaneNumber.Height = 0.2F;
            this.txtLaneNumber.Left = 0.354F;
            this.txtLaneNumber.Name = "txtLaneNumber";
            this.txtLaneNumber.Text = "txtLaneNumber";
            this.txtLaneNumber.Top = 0F;
            this.txtLaneNumber.Width = 0.1980001F;
            // 
            // label2
            // 
            this.label2.Height = 0.2F;
            this.label2.HyperLink = null;
            this.label2.Left = 0.668F;
            this.label2.Name = "label2";
            this.label2.Style = "";
            this.label2.Text = "Heat";
            this.label2.Top = 0F;
            this.label2.Width = 0.3440001F;
            // 
            // txtHeatNumber
            // 
            this.txtHeatNumber.DataField = "HeatNumber";
            this.txtHeatNumber.Height = 0.2F;
            this.txtHeatNumber.Left = 1.012F;
            this.txtHeatNumber.Name = "txtHeatNumber";
            this.txtHeatNumber.Text = "txtHeatNumber";
            this.txtHeatNumber.Top = 0F;
            this.txtHeatNumber.Width = 0.187F;
            // 
            // txtTeamName
            // 
            this.txtTeamName.DataField = "TeamName";
            this.txtTeamName.Height = 0.2F;
            this.txtTeamName.Left = 1.292F;
            this.txtTeamName.Name = "txtTeamName";
            this.txtTeamName.Text = "txtTeamName";
            this.txtTeamName.Top = 0F;
            this.txtTeamName.Width = 2.072F;
            // 
            // txtSwimmerName
            // 
            this.txtSwimmerName.DataField = "SwimmerName";
            this.txtSwimmerName.Height = 0.2F;
            this.txtSwimmerName.Left = 0F;
            this.txtSwimmerName.Name = "txtSwimmerName";
            this.txtSwimmerName.Style = "font-family: Courier New; font-size: 8.25pt; font-weight: bold; ddo-char-set: 0";
            this.txtSwimmerName.Text = "txtSwimmer";
            this.txtSwimmerName.Top = 0.251F;
            this.txtSwimmerName.Width = 6.5F;
            // 
            // line3
            // 
            this.line3.Height = 0F;
            this.line3.Left = 5.88F;
            this.line3.LineWeight = 1F;
            this.line3.Name = "line3";
            this.line3.Top = 0.19F;
            this.line3.Width = 0.5999999F;
            this.line3.X1 = 5.88F;
            this.line3.X2 = 6.48F;
            this.line3.Y1 = 0.19F;
            this.line3.Y2 = 0.19F;
            // 
            // line1
            // 
            this.line1.Height = 0F;
            this.line1.Left = 5.24F;
            this.line1.LineWeight = 1F;
            this.line1.Name = "line1";
            this.line1.Top = 0.192F;
            this.line1.Width = 0.6000004F;
            this.line1.X1 = 5.24F;
            this.line1.X2 = 5.840001F;
            this.line1.Y1 = 0.192F;
            this.line1.Y2 = 0.192F;
            // 
            // line2
            // 
            this.line2.Height = 0F;
            this.line2.Left = 4.61F;
            this.line2.LineWeight = 1F;
            this.line2.Name = "line2";
            this.line2.Top = 0.185F;
            this.line2.Width = 0.5999999F;
            this.line2.X1 = 4.61F;
            this.line2.X2 = 5.21F;
            this.line2.Y1 = 0.185F;
            this.line2.Y2 = 0.185F;
            // 
            // line4
            // 
            this.line4.Height = 0F;
            this.line4.Left = 3.98F;
            this.line4.LineWeight = 1F;
            this.line4.Name = "line4";
            this.line4.Top = 0.19F;
            this.line4.Width = 0.5999997F;
            this.line4.X1 = 3.98F;
            this.line4.X2 = 4.58F;
            this.line4.Y1 = 0.19F;
            this.line4.Y2 = 0.19F;
            // 
            // txtSeedTime
            // 
            this.txtSeedTime.DataField = "SeedTime";
            this.txtSeedTime.Height = 0.2F;
            this.txtSeedTime.Left = 3.364F;
            this.txtSeedTime.Name = "txtSeedTime";
            this.txtSeedTime.OutputFormat = resources.GetString("txtSeedTime.OutputFormat");
            this.txtSeedTime.Style = "text-align: right";
            this.txtSeedTime.Text = "textBox1";
            this.txtSeedTime.Top = 0F;
            this.txtSeedTime.Width = 0.5539999F;
            // 
            // pageFooter
            // 
            this.pageFooter.Height = 0F;
            this.pageFooter.Name = "pageFooter";
            // 
            // LaneTimerSheetByLane
            // 
            this.MasterReport = false;
            this.PageSettings.PaperHeight = 11F;
            this.PageSettings.PaperWidth = 8.5F;
            this.Sections.Add(this.pageHeader);
            this.Sections.Add(this.detail);
            this.Sections.Add(this.pageFooter);
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Arial; font-style: normal; text-decoration: none; font-weight: norma" +
            "l; font-size: 10pt; color: Black", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 16pt; font-weight: bold", "Heading1", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Times New Roman; font-size: 14pt; font-weight: bold; font-style: ita" +
            "lic", "Heading2", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 13pt; font-weight: bold", "Heading3", "Normal"));
            this.ReportStart += new System.EventHandler(this.LaneTimerSheetByLane_ReportStart);
            ((System.ComponentModel.ISupportInitialize)(this.txtEventDescription)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLaneNumber)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtHeatNumber)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtTeamName)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSwimmerName)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSeedTime)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private DataDynamics.ActiveReports.Label label1;
        private DataDynamics.ActiveReports.TextBox txtLaneNumber;
        private DataDynamics.ActiveReports.Label label2;
        private DataDynamics.ActiveReports.TextBox txtHeatNumber;
        private DataDynamics.ActiveReports.TextBox txtTeamName;
        private DataDynamics.ActiveReports.TextBox txtSwimmerName;
        private DataDynamics.ActiveReports.TextBox txtEventDescription;
        private DataDynamics.ActiveReports.Line line3;
        private DataDynamics.ActiveReports.Line line1;
        private DataDynamics.ActiveReports.Line line2;
        private DataDynamics.ActiveReports.Line line4;
        private DataDynamics.ActiveReports.TextBox txtSeedTime;
    }
}
