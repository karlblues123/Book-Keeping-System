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
                DISPLAY_SUPPLIER_LIST();
                pSupplier.Visible = false;
            }
        }


        #region EVENTS
        protected void lnkRecordExpenses_Click(object sender, EventArgs e)
        {
            DateTime dt;
            if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
            {
                txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

                Show_Message_Toast("Expense recorded.");
            }
            else
                Show_Error_Toast("Invalid input. Please check the highlighted fields.");
            //    DateTime dt;
            //    if(DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
            //    {
            //        txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

            //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Expenses recorded')", true);
            //    }
            //    else
            //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowError", "ShowError('Invalid Input. Please check.')", true);
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

                DISPLAY_EXPENSES_TYPE_LISTS();

                DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(_branchID);
            }


        }

        protected void ddUtilitySupplier_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = oBK.GET_BRANCH_DEFAULT_UTILITIES().DefaultView;
            dv.RowFilter = "ID ='" + Convert.ToInt32(ddUtilitySupplier.SelectedValue).ToString() + "'";
            if (dv.Count > 0)
            {
                foreach (DataRowView drv in dv)
                {
                    txtUtilityTIN.Text = drv.Row["TIN"].ToString();
                    ViewState["SUPPLIERID"] = Convert.ToInt32(ddUtilitySupplier.SelectedValue).ToString();
                }

            }
            else
            {
                txtUtilityTIN.Text = "";
            }
        }

        protected void lnkRecordUtility_Click(object sender, EventArgs e)
        {
            //Add is-invalid CSS class appropriately
            if (String.IsNullOrEmpty(txtSelectedBranch.Text))
                txtSelectedBranch.CssClass += " is-invalid";
            else
                txtSelectedBranch.CssClass = "form-control"; 

            if(double.Parse(txtUtilityTotal.Text) <= 0.00)
            {
                txtUtilityTotal.CssClass += " is-invalid";
            }
            else
                txtUtilityTotal.CssClass = "form-control";


            if(double.Parse(txtUtilityTotal.Text) > 0.00 && !String.IsNullOrEmpty(txtSelectedBranch.Text))
            {
                //Save the transaction record
                oBK.INSERT_BRANCH_UTILITY_TRANS(Convert.ToInt32(ViewState["V_BRANCHID"]), Convert.ToInt32(ddUtilitySupplier.SelectedValue), txtUtilityTIN.Text, txtUtilityReceipt.Text,
                                                 Convert.ToDouble(txtUtilityVATAmount.Text), Convert.ToDouble(txtUtilityNonVATAmount.Text),
                                                 Convert.ToDouble(txtUtilityVAT.Text), Convert.ToDouble(txtUtilityTotal.Text),
                                                 Convert.ToDateTime(txtUtilityFrom.Text), Convert.ToDateTime(txtUtilityTo.Text), txtUtilityParticulars.Text, txtUtilityRemarks.Text);
                CLEAR_UTILITY_INPUTS();

                //Success toast message
                Show_Message_Toast("Utility Expense transaction record successfully process.");
            }
            else
            {
                Show_Error_Toast("Invalid input. Please check the highlighted fields.");
            }

            //Condition before Saving
            if (Convert.ToDouble(txtUtilityTotal.Text) > 0)
            {


                //Save the transaction record
                oBK.INSERT_BRANCH_UTILITY_TRANS(Convert.ToInt32(ViewState["V_BRANCHID"]), Convert.ToInt32(ViewState["SUPPLIERID"]), txtSupplierName1.Text, txtUtilityTIN.Text, txtUtilityReceipt.Text,
                                                 Convert.ToDouble(txtUtilityVATAmount.Text), Convert.ToDouble(txtUtilityNonVATAmount.Text),
                                                 Convert.ToDouble(txtUtilityVAT.Text), Convert.ToDouble(txtUtilityTotal.Text),
                                                 Convert.ToDateTime(txtAppliedDate.Text), Convert.ToDateTime(txtUtilityFrom.Text), Convert.ToDateTime(txtUtilityTo.Text), txtUtilityParticulars.Text, txtUtilityRemarks.Text, Convert.ToInt16(ddExpenseType.SelectedValue));

                //Refresh display record lists
                DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(Convert.ToInt32(ViewState["V_BRANCHID"]));

                CLEAR_UTILITY_INPUTS();

                if (ddExpenseType.SelectedIndex == 1)
                {
                    //Success toast message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Utility Expense transaction record successfully process.');</script>", false);
                }
                else
                {
                    //Success toast message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Purchase transaction record successfully process.');</script>", false);

                }
            }

            else
            {
                //Success toast message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastError('Zero Total Amount Expense not allowed.');</script>", false);

            }
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

                    txtPurchaseSupplier.Text = dvr["Supplier_Name"].ToString();
                    txtPurchaseTIN.Text = dvr["TIN"].ToString();
                    upPurchase.Update();

                }
                pPurchase.Visible = true;
                pSupplier.Visible = false;
            }
        }

        protected void gvUtilitySupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //foreach (GridViewRow row in gvExpensesLists.Rows)
            //{
            //    LinkButton edit = row.FindControl("lnkSupplierSelect") as LinkButton;
            //    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
            //}
        }

        protected void lnkUtilityClear_Click(object sender, EventArgs e)
        {
            CLEAR_UTILITY_INPUTS();
        }


        protected void lnkPurchaseClear_Click(object sender, EventArgs e)
        {
            CLEAR_PURCHASE_INPUTS();
        }
        #endregion

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
                //ddUtilitySupplier.Items.Insert(0, new ListItem("*Select Provider"));
            }
            else {
                ddUtilitySupplier.DataSource = null;
                ddUtilitySupplier.DataBind();
               
                ViewState["SUPPLIERID"] = 0;
            }


        }

        private void DISPLAY_EXPENSES_TYPE_LISTS()
        {
            DataTable dt = oBK.GET_EXPENSES_LISTS();
            ddExpenseType.DataSource = dt;
            ddExpenseType.DataTextField = dt.Columns["Expenses_Desc"].ToString();
            ddExpenseType.DataValueField = dt.Columns["ExpensesID"].ToString();
            ddExpenseType.DataBind();
            ddExpenseType.Items.Insert(0, new ListItem("-Select Expense Entry-"));
        }


        private void DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(int _branchID)
        {
            DataTable dt = oBK.GET_BRANCH_EXPENSES_RECORD_LISTS(_branchID);
            if (dt.Rows.Count > 0)
            {
                gvBranchExpensesRecordLists.DataSource = dt;
                gvBranchExpensesRecordLists.DataBind();
            }
            else
            {
                gvBranchExpensesRecordLists.DataSource = null;
                gvBranchExpensesRecordLists.DataBind();
            }
        }

        private void CLEAR_UTILITY_INPUTS()
        {
            //ddUtilitySupplier.SelectedIndex = 0;
            txtUtilityReceipt.Text = "";
            txtUtilityVATAmount.Text = "0";
            txtUtilityVAT.Text = "0";
            txtUtilityNonVATAmount.Text = "0";
            txtUtilityTotal.Text = "0";
            txtUtilityParticulars.Text = "";
            txtUtilityRemarks.Text = "";

            txtSupplierName1.Text = "";
            txtUtilityTIN.Text = "";
            txtUtilityReceipt.Text = "";

            ddExpenseType.SelectedIndex = 0;

            //ddUtilitySupplier.Focus();
            txtAppliedDate.Text = oBK.GetServerDate().ToShortDateString();
            txtUtilityFrom.Text = oBK.GetServerDate().ToShortDateString();
            txtUtilityTo.Text = oBK.GetServerDate().ToShortDateString();


        }

        private void CLEAR_PURCHASE_INPUTS()
        {
            txtPurchaseSupplier.Text = String.Empty;
            txtPurchaseTIN.Text = String.Empty;
            txtPurchaseReceipt.Text = String.Empty;
            txtPurchaseVATAmount.Text = "0";
            txtPurchaseNonVATAmount.Text = "0";
            txtPurchaseVAT.Text = "0";
            txtPurchaseParticulars.Text = String.Empty;
        }

        private void DISPLAY_SUPPLIER_LIST()
        {
            DataTable dt = oMaster.GET_SUPPLIER_LISTS();

            //TODO Get Utility Suppliers and Misc Suppliers

            //Display Utility Suppliers in the list
            gvPurchaseSupplierList.DataSource = dt;
            gvPurchaseSupplierList.DataBind();

        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }


        #endregion


        protected void ddExpenseType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddExpenseType.SelectedIndex == 2)
            {
                panelSupplierDropDown.Visible = false;
                panelSupplierNameText.Visible = true;
                txtUtilityTIN.ReadOnly = false;
                
                txtUtilityTo.Visible = false;
                txtUtilityFrom.Visible = false;
            }
            else
            {
                txtSupplierName1.Text = "";
                panelSupplierDropDown.Visible = true;
                panelSupplierNameText.Visible = false;
                txtUtilityTIN.ReadOnly = true;
                txtUtilityTIN.Text = "";
                txtUtilityTo.Visible = true;
                txtUtilityFrom.Visible = true;
            }

        }
    }
}