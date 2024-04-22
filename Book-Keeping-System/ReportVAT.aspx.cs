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
    public partial class VATReport : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_LIST_COMPANIES();
                this.txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                this.txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_REPORT()
        {
            DateTime fromDate = DateTime.Parse(this.txtFromDate.Text);
            DateTime toDate = DateTime.Parse(this.txtToDate.Text);

            if(fromDate <= toDate)
            {
                if (string.Equals(rbReportType.SelectedValue, "Purchase"))
                    oReportDocument.Load(Server.MapPath("~/repVATPurchases.rpt"));
                else if (string.Equals(rbReportType.SelectedValue, "Utility"))
                    oReportDocument.Load(Server.MapPath("~/repVATUtility.rpt"));
                oReportDocument.SetParameterValue("@ACCOUNTCODE", ddCompany.SelectedValue.ToString());
                oReportDocument.SetParameterValue("@FROMDATE", fromDate);
                oReportDocument.SetParameterValue("@TODATE", toDate);
                oReportDocument.SetDatabaseLogon("sa", "p@ssw0rd"); // Supply user credentials


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
            DISPLAY_REPORT();
        }
        #endregion
    }
}