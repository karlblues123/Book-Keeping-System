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
                ddUtilityType.Items.Add(new ListItem("Electricity","1"));
                ddUtilityType.Items.Add(new ListItem("Water", "2"));
                ddUtilityType.Items.Add(new ListItem("Internet", "3"));
            }
        }

        protected void btnCompanySelectButton_Click(object sender, EventArgs e)
        {
        }

        protected void lnkMiscSubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
        }

        protected void lnkUtilitySubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Sales recorded')", true);
        }

        protected void lnkSupplierSave_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('New Supplier saved.')", true);
        }

        //private void Show_Error_Toast(string msg)
        //{
        //    lblErrorMsg.Text = msg;
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "ShowError()", true);
        //}
    }
}