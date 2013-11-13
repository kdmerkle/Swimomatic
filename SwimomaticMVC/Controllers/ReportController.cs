using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using SwimomaticMVC.Reports;
using SwimomaticMVC.Models;
using Swimomatic.Entity;
using SwimomaticBusinessLib;
using System.IO;
using DataDynamics.ActiveReports.Export.Pdf;

namespace SwimomaticMVC.Controllers
{
    public class ReportController : ControllerBase
    {
        //
        // GET: /Report/

        public FileStreamResult LaneTimerSheetByHeatSheetEvent(int HeatSheetEventID)
        {
            ReportHeatSheetEventCollection hses = BizMgr.GetReportHeatSheetEventByHeatSheetEventID(HeatSheetEventID);
            return GenerateTimerSheetReport(hses);
        }

        public FileStreamResult LaneTimerSheetByHeatSheet(int HeatSheetID)
        {
            ReportHeatSheetEventCollection hses = BizMgr.GetReportHeatSheetEventByHeatSheetID(HeatSheetID);
            return GenerateTimerSheetReport(hses);
        }

        public FileStreamResult LaneTimerSheetByHeat(int HeatID)
        {
            ReportHeatSheetEventCollection hses = BizMgr.GetReportHeatSheetEventByHeatID(HeatID);
            return GenerateTimerSheetReport(hses);
        }

        private static FileStreamResult GenerateTimerSheetReport(ReportHeatSheetEventCollection hses)
        {
            LaneTimerSheetByLane rpt = new LaneTimerSheetByLane();

            int laneCount = 0;
            string eventDescription = "";
            if (hses.Count(l => l.LaneCount > 0) > 0)
            {
                ReportHeatSheetEvent rsh = hses.Where(h => h.LaneCount > 0).FirstOrDefault();
                laneCount = rsh.LaneCount;
                eventDescription = rsh.EventDescription;
            }
            //rpt.LaneCount = laneCount;
            //rpt.EventDescription = eventDescription;

            rpt.DataSource = hses;
            rpt.PageSettings.Margins.Left = 0.5F;
            rpt.PageSettings.Margins.Right = 0.5F;
            rpt.PageSettings.Margins.Top = 0.5F;
            rpt.PageSettings.Margins.Bottom = 0.5F;
            rpt.Run();

            MemoryStream reportStream = new MemoryStream();
            new PdfExport().Export(rpt.Document, reportStream);

            byte[] byteInfo = reportStream.ToArray();
            reportStream.Write(byteInfo, 0, byteInfo.Length);
            reportStream.Position = 0;

            return new FileStreamResult(reportStream, "application/pdf");
        }

    }

}
