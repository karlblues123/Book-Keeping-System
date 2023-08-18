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
    public partial class BranchSalesExpenses : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void lnkRecordSale_Click(object sender, EventArgs e)
        {
            DateTime dt;
            if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None,out dt))
            {
                txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Sales recorded')", true);
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowError", "ShowError('Invalid Input. Please check.')", true);
        }

        protected void lnkRecordExpenses_Click(object sender, EventArgs e)
        {
            DateTime dt;
            if(DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
            {
                txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Expenses recorded')", true);
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowError", "ShowError('Invalid Input. Please check.')", true);
        }

        protected void lnkSupplierSave_Click(object sender, EventArgs e)
        {
            txtSupplierTIN.Text = txtNewTin.Text;
            pPurchase.Visible = true;
            pSupplier.Visible = false;
        }

        protected void lnkNewSupplier_Click(object sender, EventArgs e)
        {
            pSupplier.Visible = true;
            pPurchase.Visible = false;
        }

        protected void lnkSupplierBack_Click(object sender, EventArgs e)
        {
            pPurchase.Visible = true;
            pSupplier.Visible = false;
        }
    }
}