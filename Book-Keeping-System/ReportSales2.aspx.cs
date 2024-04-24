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
                this.txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd"); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
                this.txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd"); //oSys.GET_SERVER_DATE_TIME().ToShortDateString();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_REPORT()
        {
            //Get the date coverage
            DateTime dtStartDate = DateTime.Parse(this.txtFromDate.Text);
            DateTime dtEndDate = DateTime.Parse(this.txtToDate.Text);

            if (dtStartDate <= dtEndDate)
            {
                //Load the report
                this.oReportDocument.Load(Server.MapPath("~/repColumnarSales.rpt"));

                //Set the parameters needed
                this.oReportDocument.SetParameterValue("@FROMDATE", dtStartDate);
                this.oReportDocument.SetParameterValue("@TODATE", dtEndDate);
                this.oReportDocument.SetParameterValue("@COMPANYCODE", this.ddCompany.SelectedValue.ToString());

                this.oReportDocument.SetDatabaseLogon("sa", "p@ssw0rd"); // Supply user credentials

                //Display the data
                this.CRV.ReportSource = this.oReportDocument;
                this.lblNoReport.Visible = false;

                this.txtFromDate.CssClass = "form-control";
                this.txtToDate.CssClass = "form-control";
            }
            else
            {
                this.Show_Error_Toast("Error - Date input is invalid.");

                this.txtFromDate.CssClass += " is-invalid";
                this.txtToDate.CssClass += " is-invalid";

                this.CRV.ReportSource = null;
                this.lblNoReport.Visible = true;
            }
                
            
        }

        private void DISPLAY_LIST_COMPANIES()
        {
            DataTable data = this.oMaster.GET_COMPANY_LISTS();

            this.ddCompany.DataTextField = "Company_Name";
            this.ddCompany.DataValueField = "CompanyCode";
            this.ddCompany.DataSource = data;
            this.ddCompany.DataBind();
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS

        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            this.DISPLAY_REPORT();
        }

        #endregion
    }
}