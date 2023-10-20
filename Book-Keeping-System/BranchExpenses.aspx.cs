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
    public partial class BranchExpenses : System.Web.UI.Page
    {

        MasterC oMaster = new MasterC();
        BKC oBK = new BKC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_BRANCH_LISTS();
                CLEAR_UTILITY_INPUTS();
            }
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
            string _branchCode = r.Cells[1].Text;
            ViewState["V_BRANCHID"] = Convert.ToInt32(r.Cells[0].Text);



            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchCode='" + _branchCode + "'";


            if (dv.Count > 0)
            {
                //Disable the script to directly input on expenses form 10.19.2023
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableNavs", "EnableNavs()", true);
                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtSelectedBranch.Text = dvr["Branch_Name"].ToString().Trim();

                }

                DISPLAY_UTILITIES(_branchCode);

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

        private void DISPLAY_UTILITIES(string _branchCode)
        {
            DataTable dt = oBK.GET_BRANCH_DEFAULT_UTILITIES();
            DataView dv = dt.DefaultView;
            dv.RowFilter = "BranchCode = '" + _branchCode + "'";

            if (dv.Count > 0)
            {
                ddUtilitySupplier.DataSource = dv;
                ddUtilitySupplier.DataTextField = dv.Table.Columns["ProviderName"].ToString();
                ddUtilitySupplier.DataValueField = dv.Table.Columns["ID"].ToString();
                ddUtilitySupplier.DataBind();
            }
            else {
                ddUtilitySupplier.Items.Clear();

            }


        }


        private void CLEAR_UTILITY_INPUTS()
        {
            ddUtilitySupplier.SelectedIndex = 0;
            txtUtilityReceipt.Text = "";
            txtUtilityVATAmount.Text = "0";
            txtUtilityVAT.Text = "0";
            txtUtilityNonVATAmount.Text = "0";
            txtUtilityTotal.Text = "0";
            txtUtilityParticulars.Text = "";
            txtUtilityRemarks.Text = "";

            ddUtilitySupplier.Focus();
            txtUtilityFrom.Text = oBK.GetServerDate().ToShortDateString();
            txtUtilityTo.Text = oBK.GetServerDate().ToShortDateString();
        }

        #endregion

        protected void ddUtilitySupplier_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = oBK.GET_BRANCH_DEFAULT_UTILITIES().DefaultView;
            dv.RowFilter = "ID ='" + Convert.ToInt32(ddUtilitySupplier.SelectedValue).ToString() + "'";
            if (dv.Count > 0)
            {
                foreach (DataRowView drv in dv)
                {
                    txtUtilityTIN.Text = drv.Row["TIN"].ToString();
              
                }
                
            }
            else
            {
                txtUtilityTIN.Text = "";
            }
        }

        protected void lnkRecordUtility_Click(object sender, EventArgs e)
        {
            //Save the transaction record
            oBK.INSERT_BRANCH_UTILITY_TRANS(Convert.ToInt32(ViewState["V_BRANCHID"]), Convert.ToInt32(ddUtilitySupplier.SelectedValue), txtUtilityTIN.Text, txtUtilityReceipt.Text,
                                             Convert.ToDouble(txtUtilityVATAmount.Text), Convert.ToDouble(txtUtilityNonVATAmount.Text),
                                             Convert.ToDouble(txtUtilityVAT.Text), Convert.ToDouble(txtUtilityTotal.Text),
                                             Convert.ToDateTime(txtUtilityFrom.Text), Convert.ToDateTime(txtUtilityTo.Text), txtUtilityParticulars.Text, txtUtilityRemarks.Text);
            CLEAR_UTILITY_INPUTS();

            //Success toast message
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Utility Expense transaction record successfully process.');</script>", false);

        }
    }
}