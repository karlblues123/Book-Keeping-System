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
                DISPLAY_SUPPLIER_LIST();

            }
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

        private void DISPLAY_SUPPLIER_LIST()
        {
            DataTable dt = oMaster.GET_SUPPLIER_LISTS();

            //TODO Get Utility Suppliers and Misc Suppliers

            //Display Utility Suppliers in the list
            gvSupplierList.DataSource = dt;
            gvSupplierList.DataBind();

        }

        private void CLEAR_INPUT()
        {
            txtUtilitySupplier.Text = String.Empty;
            txtUtilityTIN.Text = String.Empty;
            txtUtilityReceipt.Text = String.Empty;
            txtUtilityVATAmount.Text = "0";
            txtUtilityNonVATAmount.Text = "0";
            txtUtilityVAT.Text = "0";
            txtUtilityTotal.Text = "0";
            txtUtilityFrom.Text = String.Empty;
            txtUtilityTo.Text = String.Empty;

            txtMiscSupplier.Text = String.Empty;
            txtMiscTIN.Text = String.Empty;
            txtMiscReceipt.Text = String.Empty;
            txtMiscVATAmount.Text = "0";
            txtMiscNonVATAmount.Text = "0";
            txtMiscVAT.Text = "0";
            txtMiscTotal.Text = "0";

        }

        private void CLEAR_NEW_SUPPLIER_INPUT()
        {
            txtSupplierName.Text = String.Empty;
            txtSupplierAddress.Text = String.Empty;
            txtSupplierTIN.Text = String.Empty;

            txtSupplierName.CssClass = "form-control";
            txtSupplierAddress.CssClass = "form-control";
            txtSupplierTIN.CssClass = "form-control";
        }


        #endregion

        #region EVENTS

        protected void lnkMiscSubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
            CLEAR_INPUT();
        }

        protected void lnkUtilitySubmit_Click(object sender, EventArgs e)
        {
            Show_Message_Toast("Expenses recorded");
            CLEAR_INPUT();
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Sales recorded')", true);
        }

        protected void lnkSupplierSave_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtSupplierName.Text))
                txtSupplierName.CssClass += " is-invalid";
            if (String.IsNullOrEmpty(txtSupplierTIN.Text))
                txtSupplierTIN.CssClass += " is-invalid";
            if (String.IsNullOrEmpty(txtSupplierAddress.Text))
                txtSupplierAddress.CssClass += " is-invalid";

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('New Supplier saved.')", true);
        }

        protected void lnkSupplierSelect_Click(object sender, EventArgs e)
        {

            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = Convert.ToInt32(r.Cells[0].Text);

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + _supplierID + "'";

            //TODO ViewState Is Supplier Non-VAT
            if (dv.Count > 0)
            {
                foreach (DataRowView dvr in dv)
                {
                    if(hfMode.Value.Equals("util"))
                    {
                        txtUtilitySupplier.Text = dvr["Supplier_Name"].ToString();
                        txtUtilityTIN.Text = dvr["TIN"].ToString();
                        upUtility.Update();
                    }
                    else if(hfMode.Value.Equals("misc"))
                    {
                        txtMiscSupplier.Text = dvr["Supplier_Name"].ToString();
                        txtMiscTIN.Text = dvr["TIN"].ToString();
                        upMisc.Update();
                    }
                }
            }
        }

        protected void gvSupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (GridViewRow row in gvSupplierList.Rows)
            {
                LinkButton edit = row.FindControl("lnkSupplierSelect") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
            }
        }

        protected void lnkInputClear_Click(object sender, EventArgs e)
        {
            CLEAR_INPUT();
        }

        protected void lnkSupplierClear_Click(object sender, EventArgs e)
        {
            CLEAR_NEW_SUPPLIER_INPUT();
        }


        #endregion



        //private void Show_Error_Toast(string msg)
        //{
        //    lblErrorMsg.Text = msg;
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "ShowError()", true);
        //}
    }
}