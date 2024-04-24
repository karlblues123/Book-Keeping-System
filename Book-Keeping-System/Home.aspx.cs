using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Home : System.Web.UI.Page
    {
        BKC oBK = new BKC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_NO_SALE_BRANCHES();
                this.DISPLAY_EXPIRING_CONTRACT_BRANCHES();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_NO_SALE_BRANCHES()
        {
            //Get the dates of the previous month
            var today = DateTime.Today;
            var month = new DateTime(today.Year, today.Month, 1);
            DateTime from_date = month.AddMonths(-1);
            DateTime to_date = month.AddDays(-1);

            //Display the month
            this.lblMissingSales.Text = "Missing Sales for " + from_date.ToString("MMMM");

            //Get the list of branches that have no sales for the previous month
            DataTable data = this.oBK.GET_NO_SALE_LIST_BRANCHES(from_date, to_date);

            //Display the data
            this.gvNoSalesBranch.DataSource = data;
            this.gvNoSalesBranch.DataBind();
            this.pMissingSales.Visible = (data.Rows.Count > 0);
        }

        private void DISPLAY_EXPIRING_CONTRACT_BRANCHES()
        {
            //Get the dates of the next month
            DateTime today = DateTime.Today;
            DateTime from_date = new DateTime(today.Year,today.Month,1);
            DateTime next_month = today.AddMonths(1);
            DateTime to_date = new DateTime(next_month.Year, next_month.Month, DateTime.DaysInMonth(next_month.Year, next_month.Month));

            //Get the list of branches with expiring contracts
            DataTable data = this.oBK.GET_EXPIRING_CONTRACT_BRANCHES(from_date, to_date);

            //Display the data
            this.gvExpiringContractBranch.DataSource = data;
            this.gvExpiringContractBranch.DataBind();
            this.pExpiringContracts.Visible = (data.Rows.Count > 0);
        }
        #endregion
    }
}