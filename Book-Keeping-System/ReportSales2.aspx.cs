using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;


namespace Book_Keeping_System
{
    public partial class ReportSales2 : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDateFrom.Text = DateTime.Now.ToShortDateString(); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
                txtDateTo.Text = DateTime.Now.ToShortDateString(); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
            }

            displayReport();
        }
        private void displayReport()
        {
            DateTime dtStartDate = Convert.ToDateTime(txtDateFrom.Text);
            DateTime dtEndDate = Convert.ToDateTime(txtDateTo.Text);

            ParameterRangeValue myDateRangeValue = new ParameterRangeValue();
            myDateRangeValue.StartValue = dtStartDate; 
            myDateRangeValue.EndValue = dtEndDate;



            oReportDocument.Load(Server.MapPath("~/repColumnarSales.rpt"));

            oReportDocument.SetParameterValue("date_coverage", myDateRangeValue);
            
            oReportDocument.SetDatabaseLogon("sa", "p@ssw0rd"); // Supply user credentials

           
           CRV.ReportSource = oReportDocument;

        }

        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            //call display refresh
            displayReport();
        }
    }
}