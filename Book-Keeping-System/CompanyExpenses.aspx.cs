using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    

    public partial class CompanyExpenses : System.Web.UI.Page
    {
        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ddUtilityType.Items.Add(new ListItem("Electricity","1"));
                ddUtilityType.Items.Add(new ListItem("Water", "2"));
                ddUtilityType.Items.Add(new ListItem("Internet", "3"));

                DISPLAY_COMPANY_LISTS();
            }
        }

        protected void btnCompanySelectButton_Click(object sender, EventArgs e)
        {
            txtSelectedCompany.Text = ddCompanyList.SelectedItem.Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableNavs", "EnableNavs()", true);
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

        #region LOCAL FUNCTIONS

        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable dt = oMaster.GET_COMPANY_LISTS();

            ddCompanyList.DataSource = dt;
            ddCompanyList.DataTextField = dt.Columns["Company_Name"].ToString();
            ddCompanyList.DataValueField = dt.Columns["CompanyCode"].ToString();
            ddCompanyList.DataBind();
        }

        #endregion

        //private void Show_Error_Toast(string msg)
        //{
        //    lblErrorMsg.Text = msg;
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "ShowError()", true);
        //}
    }
}