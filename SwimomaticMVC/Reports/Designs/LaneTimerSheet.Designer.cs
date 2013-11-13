namespace SwimomaticMVC.Reports
{
    /// <summary>
    /// Summary description for NewActiveReport1.
    /// </summary>
    partial class LaneTimerSheet
    {
        private DataDynamics.ActiveReports.Detail detail;

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
            System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(LaneTimerSheet));
            this.detail = new DataDynamics.ActiveReports.Detail();
            this.label1 = new DataDynamics.ActiveReports.Label();
            this.lblLaneNumber = new DataDynamics.ActiveReports.Label();
            this.line1 = new DataDynamics.ActiveReports.Line();
            this.line2 = new DataDynamics.ActiveReports.Line();
            this.line3 = new DataDynamics.ActiveReports.Line();
            this.label2 = new DataDynamics.ActiveReports.Label();
            this.lblEvent = new DataDynamics.ActiveReports.Label();
            this.label3 = new DataDynamics.ActiveReports.Label();
            this.lblHeatNumber = new DataDynamics.ActiveReports.Label();
            this.groupHeader1 = new DataDynamics.ActiveReports.GroupHeader();
            this.groupFooter1 = new DataDynamics.ActiveReports.GroupFooter();
            this.txtSwimmerName = new DataDynamics.ActiveReports.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.label1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblLaneNumber)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblEvent)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.label3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblHeatNumber)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSwimmerName)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // detail
            // 
            this.detail.ColumnDirection = DataDynamics.ActiveReports.ColumnDirection.AcrossDown;
            this.detail.ColumnSpacing = 0.05F;
            this.detail.Controls.AddRange(new DataDynamics.ActiveReports.ARControl[] {
            this.label1,
            this.lblLaneNumber,
            this.line1,
            this.line2,
            this.line3,
            this.txtSwimmerName});
            this.detail.Height = 1.25F;
            this.detail.KeepTogether = true;
            this.detail.Name = "detail";
            // 
            // label1
            // 
            this.label1.Height = 0.2F;
            this.label1.HyperLink = null;
            this.label1.Left = 2.793968E-09F;
            this.label1.Name = "label1";
            this.label1.Style = "font-size: 8pt; font-weight: bold";
            this.label1.Text = "Lane ";
            this.label1.Top = 0F;
            this.label1.Width = 0.322F;
            // 
            // lblLaneNumber
            // 
            this.lblLaneNumber.DataField = "LaneNumber";
            this.lblLaneNumber.Height = 0.2F;
            this.lblLaneNumber.HyperLink = null;
            this.lblLaneNumber.Left = 0.325F;
            this.lblLaneNumber.Name = "lblLaneNumber";
            this.lblLaneNumber.Style = "font-size: 8pt; font-weight: bold";
            this.lblLaneNumber.Text = "lblLaneNumber";
            this.lblLaneNumber.Top = 0F;
            this.lblLaneNumber.Width = 0.2920001F;
            // 
            // line1
            // 
            this.line1.Height = 0.0002500415F;
            this.line1.Left = 0F;
            this.line1.LineWeight = 1F;
            this.line1.Name = "line1";
            this.line1.Top = 0.75575F;
            this.line1.Width = 0.875F;
            this.line1.X1 = 0F;
            this.line1.X2 = 0.875F;
            this.line1.Y1 = 0.756F;
            this.line1.Y2 = 0.75575F;
            // 
            // line2
            // 
            this.line2.Height = 0.0002501011F;
            this.line2.Left = 0F;
            this.line2.LineWeight = 1F;
            this.line2.Name = "line2";
            this.line2.Top = 0.98875F;
            this.line2.Width = 0.875F;
            this.line2.X1 = 0F;
            this.line2.X2 = 0.875F;
            this.line2.Y1 = 0.9890001F;
            this.line2.Y2 = 0.98875F;
            // 
            // line3
            // 
            this.line3.Height = 0.0002499819F;
            this.line3.Left = 0F;
            this.line3.LineWeight = 1F;
            this.line3.Name = "line3";
            this.line3.Top = 1.22175F;
            this.line3.Width = 0.875F;
            this.line3.X1 = 0F;
            this.line3.X2 = 0.875F;
            this.line3.Y1 = 1.222F;
            this.line3.Y2 = 1.22175F;
            // 
            // label2
            // 
            this.label2.Height = 0.2F;
            this.label2.HyperLink = null;
            this.label2.Left = 0F;
            this.label2.Name = "label2";
            this.label2.Style = "font-weight: bold";
            this.label2.Text = "Event:";
            this.label2.Top = 0F;
            this.label2.Width = 0.5420001F;
            // 
            // lblEvent
            // 
            this.lblEvent.DataField = "EventDescription";
            this.lblEvent.Height = 0.2F;
            this.lblEvent.HyperLink = null;
            this.lblEvent.Left = 0.468F;
            this.lblEvent.Name = "lblEvent";
            this.lblEvent.Style = "font-weight: bold";
            this.lblEvent.Text = "label3";
            this.lblEvent.Top = 0F;
            this.lblEvent.Width = 5.031F;
            // 
            // label3
            // 
            this.label3.Height = 0.2F;
            this.label3.HyperLink = null;
            this.label3.Left = 0F;
            this.label3.Name = "label3";
            this.label3.Style = "font-weight: bold";
            this.label3.Text = "Heat:";
            this.label3.Top = 0.232F;
            this.label3.Width = 0.448F;
            // 
            // lblHeatNumber
            // 
            this.lblHeatNumber.DataField = "HeatNumber";
            this.lblHeatNumber.Height = 0.2F;
            this.lblHeatNumber.HyperLink = null;
            this.lblHeatNumber.Left = 0.448F;
            this.lblHeatNumber.Name = "lblHeatNumber";
            this.lblHeatNumber.Style = "font-weight: bold";
            this.lblHeatNumber.Text = "label4";
            this.lblHeatNumber.Top = 0.232F;
            this.lblHeatNumber.Width = 1F;
            // 
            // groupHeader1
            // 
            this.groupHeader1.ColumnLayout = false;
            this.groupHeader1.Controls.AddRange(new DataDynamics.ActiveReports.ARControl[] {
            this.lblHeatNumber,
            this.label2,
            this.lblEvent,
            this.label3});
            this.groupHeader1.DataField = "HeatID";
            this.groupHeader1.GroupKeepTogether = DataDynamics.ActiveReports.GroupKeepTogether.FirstDetail;
            this.groupHeader1.Height = 0.432F;
            this.groupHeader1.Name = "groupHeader1";
            this.groupHeader1.Format += new System.EventHandler(this.groupHeader1_Format);
            // 
            // groupFooter1
            // 
            this.groupFooter1.Height = 0.5416667F;
            this.groupFooter1.Name = "groupFooter1";
            // 
            // txtSwimmerName
            // 
            this.txtSwimmerName.DataField = "SwimmerName";
            this.txtSwimmerName.Height = 0.323F;
            this.txtSwimmerName.Left = 0F;
            this.txtSwimmerName.Name = "txtSwimmerName";
            this.txtSwimmerName.Style = "font-size: 8pt";
            this.txtSwimmerName.Text = "textBox1";
            this.txtSwimmerName.Top = 0.2F;
            this.txtSwimmerName.Width = 1F;
            // 
            // LaneTimerSheet
            // 
            this.MasterReport = false;
            this.PageSettings.PaperHeight = 11F;
            this.PageSettings.PaperWidth = 8.5F;
            this.PrintWidth = 7.5F;
            this.Sections.Add(this.groupHeader1);
            this.Sections.Add(this.detail);
            this.Sections.Add(this.groupFooter1);
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Arial; font-style: normal; text-decoration: none; font-weight: norma" +
            "l; font-size: 10pt; color: Black", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 16pt; font-weight: bold", "Heading1", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-family: Times New Roman; font-size: 14pt; font-weight: bold; font-style: ita" +
            "lic", "Heading2", "Normal"));
            this.StyleSheet.Add(new DDCssLib.StyleSheetRule("font-size: 13pt; font-weight: bold", "Heading3", "Normal"));
            this.ReportStart += new System.EventHandler(this.LaneTimerSheet_ReportStart);
            ((System.ComponentModel.ISupportInitialize)(this.label1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblLaneNumber)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblEvent)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.label3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lblHeatNumber)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtSwimmerName)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private DataDynamics.ActiveReports.Label label1;
        private DataDynamics.ActiveReports.Label lblLaneNumber;
        private DataDynamics.ActiveReports.Line line1;
        private DataDynamics.ActiveReports.Line line2;
        private DataDynamics.ActiveReports.Line line3;
        private DataDynamics.ActiveReports.Label label2;
        private DataDynamics.ActiveReports.Label lblEvent;
        private DataDynamics.ActiveReports.Label label3;
        private DataDynamics.ActiveReports.Label lblHeatNumber;
        private DataDynamics.ActiveReports.GroupHeader groupHeader1;
        private DataDynamics.ActiveReports.GroupFooter groupFooter1;
        private DataDynamics.ActiveReports.TextBox txtSwimmerName;
    }
}
