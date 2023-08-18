using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class CompanyExpenses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                PopulateMonthList();
            }
        }

        protected void btnCompanySelectButton_Click(object sender, EventArgs e)
        {
        }

        private void PopulateMonthList()
        {
            for (int month = 1; month <= 12; month++)
            {
                string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(month);
                ddMonth.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
        }

        protected void lnkMiscSubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
        }

        protected void lnkWaterSubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
        }

        protected void lnkElectricitySubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Sales recorded')", true);
        }

        //private void Show_Error_Toast(string msg)
        //{
        //    lblErrorMsg.Text = msg;
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "ShowError()", true);
        //}
    }
}