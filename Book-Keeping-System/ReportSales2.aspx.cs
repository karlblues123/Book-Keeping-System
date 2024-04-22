using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;


namespace Book_Keeping_System
{
    public partial class ReportSales2 : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_LIST_COMPANIES();
                this.txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd"); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
                this.txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd"); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_REPORT()
        {
            //Get the date coverage
            DateTime dtStartDate = DateTime.Parse(txtDateFrom.Text);
            DateTime dtEndDate = DateTime.Parse(txtDateTo.Text);

            if (dtStartDate <= dtEndDate)
            {
                //Load the report
                oReportDocument.Load(Server.MapPath("~/repColumnarSales.rpt"));

                //Set the parameters needed
                oReportDocument.SetParameterValue("@FROMDATE", dtStartDate);
                oReportDocument.SetParameterValue("@TODATE", dtEndDate);
                oReportDocument.SetParameterValue("@COMPANYCODE", ddCompany.SelectedValue.ToString());

                oReportDocument.SetDatabaseLogon("sa", "p@ssw0rd"); // Supply user credentials

                //Display the data
                CRV.ReportSource = oReportDocument;
                this.lblNoReport.Visible = false;
            }
            else
            {
                this.Show_Error_Toast("Error - Date input is invalid.");

                CRV.ReportSource = null;
                this.lblNoReport.Visible = true;
            }
                
            
        }

        private void DISPLAY_LIST_COMPANIES()
        {
            DataTable data = oMaster.GET_COMPANY_LISTS();

            ddCompany.DataTextField = "Company_Name";
            ddCompany.DataValueField = "CompanyCode";
            ddCompany.DataSource = data;
            ddCompany.DataBind();
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS

        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            //call display refresh
            DISPLAY_REPORT();
        }

        #endregion
    }
}