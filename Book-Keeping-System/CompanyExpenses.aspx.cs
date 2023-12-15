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

            gvSupplierList.DataSource = dt;
            gvSupplierList.DataBind();

        }

        private void CLEAR_UTILITY_INPUT()
        {
            //Clear fields
            txtUtilitySupplier.Text = String.Empty;
            txtUtilityTIN.Text = String.Empty;
            txtUtilityReceipt.Text = String.Empty;
            txtUtilityVATAmount.Text = "0";
            txtUtilityNonVATAmount.Text = "0";
            txtUtilityVAT.Text = "0";
            txtUtilityTotal.Text = "0";
            txtUtilityFrom.Text = String.Empty;
            txtUtilityTo.Text = String.Empty;

            //Set CSS classes to default
            txtDate.CssClass = "form-control";
            txtUtilitySupplier.CssClass = "form-control";
            txtUtilityTIN.CssClass = "form-control";
            txtUtilityTotal.CssClass = "form-control";
            
        }

        private void CLEAR_MISC_INPUT()
        {
            //Clear fields
            txtMiscSupplier.Text = String.Empty;
            txtMiscTIN.Text = String.Empty;
            txtMiscReceipt.Text = String.Empty;
            txtMiscVATAmount.Text = "0";
            txtMiscNonVATAmount.Text = "0";
            txtMiscVAT.Text = "0";
            txtMiscTotal.Text = "0";
            txtMiscParticulars.Text = String.Empty;

            //Set CSS classes to default
            txtDate.CssClass = "form-control";
            txtDate.CssClass = "form-control";
            txtMiscTotal.CssClass = "form-control";
        }

        private void CLEAR_NEW_SUPPLIER_INPUT()
        {
            //Clear fields
            txtSupplierName.Text = String.Empty;
            txtSupplierAddress.Text = String.Empty;
            txtSupplierTIN.Text = String.Empty;

            //Set CSS classes to default
            txtSupplierName.CssClass = "form-control";
            txtSupplierAddress.CssClass = "form-control";
            txtSupplierTIN.CssClass = "form-control";
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('"+ msg +"');</script>", false);
        }

        #endregion

        #region EVENTS

        protected void lnkMiscSubmit_Click(object sender, EventArgs e)
        {

            DateTime dt;

            //Add is-valid CSS class appropriately
            if (!DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
                txtDate.CssClass += " is-invalid";
            else
                txtDate.CssClass = "form-control";

            if (double.Parse(txtMiscTotal.Text) <= 0.00)
                txtMiscTotal.CssClass += " is-invalid";
            else
                txtMiscTotal.CssClass = "form-control";

            //Validate Input
            if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt) && double.Parse(txtMiscTotal.Text) > 0.00)
            {
                //TODO Insert to database
                Show_Message_Toast("Expenses recorded");
                CLEAR_MISC_INPUT();
            }
            else
            {
                Show_Error_Toast("Invalid Input. Please check the highlighted fields.");
            }
                
        }

        protected void lnkUtilitySubmit_Click(object sender, EventArgs e)
        {
            DateTime dt;

            //Add is-invalid CSS class appropriately
            if (String.IsNullOrEmpty(txtUtilitySupplier.Text))
            {
                txtUtilitySupplier.CssClass += " is-invalid";
                txtUtilityTIN.CssClass += " is-invalid";
            }
                
            else
            {
                txtUtilitySupplier.CssClass = "form-control";
                txtUtilityTIN.CssClass = "form-control";
            }

            if (double.Parse(txtUtilityTotal.Text) <= 0.00)
            {
                txtUtilityTotal.CssClass += " is-invalid";
            }
            else
                txtUtilityTotal.CssClass = "form-control";
                
            if (!DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
                txtDate.CssClass += " is-invalid";
            else
                txtDate.CssClass = "form-control";

            //Validate input
            if (!String.IsNullOrEmpty(txtUtilitySupplier.Text) && DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt) && double.Parse(txtUtilityTotal.Text) > 0.00)
            {
                //TODO Insert to database
                Show_Message_Toast("Expenses recorded");
                CLEAR_UTILITY_INPUT();
            }
            else
                Show_Error_Toast("Invalid Input. Please check the highlighted fields.");
        }
        

        protected void lnkSupplierSave_Click(object sender, EventArgs e)
        {
            //Add is-invalid CSS class appropriately
            if (String.IsNullOrEmpty(txtSupplierName.Text))
                txtSupplierName.CssClass += " is-invalid";
            else
                txtSupplierName.CssClass = "form-control";

            if (String.IsNullOrEmpty(txtSupplierTIN.Text))
                txtSupplierTIN.CssClass += " is-invalid";
            else
                txtSupplierTIN.CssClass = "form-control";

            if (String.IsNullOrEmpty(txtSupplierAddress.Text))
                txtSupplierAddress.CssClass += " is-invalid";
            else
                txtSupplierAddress.CssClass = "form-control";

            //Validate Input
            if(!String.IsNullOrEmpty(txtSupplierName.Text) && !String.IsNullOrEmpty(txtSupplierTIN.Text) && !String.IsNullOrEmpty(txtSupplierAddress.Text))
            {
                //TODO Insert to database
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('New Supplier saved.')", true);
                CLEAR_NEW_SUPPLIER_INPUT();
            }
            else
                Show_Error_Toast("Invalid Input. Please check the highlighted fields.");
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

        protected void lnkUtilityClear_Click(object sender, EventArgs e)
        {
            CLEAR_UTILITY_INPUT();
        }

        protected void lnkSupplierClear_Click(object sender, EventArgs e)
        {
            CLEAR_NEW_SUPPLIER_INPUT();
        }

        protected void lnkMiscClear_Click(object sender, EventArgs e)
        {
            CLEAR_MISC_INPUT();
        }


        #endregion



        //private void Show_Error_Toast(string msg)
        //{
        //    lblErrorMsg.Text = msg;
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "ShowError()", true);
        //}
    }
}