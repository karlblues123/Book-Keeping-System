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

        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_BRANCH_LISTS();
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
            //txtSupplierTIN.Text = txtNewTin.Text;
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

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _branchID = Convert.ToInt32(r.Cells[0].Text);
            //ViewState["V_SUPPLIERID"] = _supplierID;



            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchID='" + _branchID + "'";


            if (dv.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableNavs", "EnableNavs()", true);
                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtSelectedBranch.Text = dvr["Branch_Name"].ToString().Trim();

                }
                
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_BRANCH_LISTS()
        {
            DataTable dt = oMaster.GET_BRANCH_LISTS();

            //Display sa gridview
            gvBranchList.DataSource = dt;
            gvBranchList.DataBind();
        }
        #endregion

        
    }
}