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
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_BRANCH_LISTS();
                this.DISPLAY_EXPENSE_TYPES();
                //CLEAR_UTILITY_INPUTS();
                this.DISPLAY_SUPPLIER_LIST();
                //pSupplier.Visible = false;
                if (Session["EditExpense"] != null)
                {
                    this.hiddenSelectedExpense.Value = Session["EditExpense"].ToString();
                    int id = int.Parse(Session["EditExpense"].ToString());
                    this.DISPLAY_SELECTED_EXPENSE(id);
                    Session.Remove("EditExpense");
                }
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_BRANCH_LISTS()
        {
            DataView data = oMaster.GET_BRANCH_LISTS().DefaultView;
            data.RowFilter = "IsActive = 1";

            //Display the data in the GridView
            gvBranchList.DataSource = data;
            gvBranchList.DataBind();
        }

        private void DISPLAY_EXPENSE_TYPES()
        {
            DataTable data = oBK.GET_EXPENSE_TYPES();

            ddType.DataTextField = "TypeName";
            ddType.DataValueField = "ID";
            ddType.DataSource = data;
            ddType.DataBind();
        }

        private void DISPLAY_SUPPLIER_LIST()
        {
            DataTable data = this.oMaster.GET_SUPPLIER_LISTS();

            this.gvSupplierList.DataSource = data;
            this.gvSupplierList.DataBind();

        }

        private void DISPLAY_BRANCH_EXPENSES(string branch_code)
        {
            //Get the list of expenses of a company
            DataTable data = this.oBK.GET_LIST_EXPENSES(branch_code);

            //Display the output to the controls
            this.gvExpenses.DataSource = data;
            this.gvExpenses.DataBind();
        }

        private void DISPLAY_SELECTED_EXPENSE(int id)
        {
            //Get the data
            DataRow data = this.oBK.GET_SELECTED_EXPENSE(id).Rows[0];

            //Display the data
            this.txtSupplier.Text = data["Supplier_Name"].ToString();
            this.txtTIN.Text = data["TIN"].ToString();
            this.txtInvoice.Text = data["Invoice"].ToString();
            this.txtVATAmount.Text = data["VATable"].ToString();
            this.txtNonVATAmount.Text = data["NonVAT"].ToString();
            this.txtVAT.Text = data["VATAmount"].ToString();
            this.txtTotal.Text = data["TotalAmount"].ToString();
            this.txtTendered.Text = data["AmountTendered"].ToString();
            this.txtUtilityFrom.Text = data["FromDate"].ToString();
            this.txtUtilityTo.Text = data["ToDate"].ToString();
            this.txtAccountNumber.Text = data["AccountNumber"].ToString();
            this.hiddenSelectedBranch.Value = data["AccountCode"].ToString();
            this.hiddenSelectedSupplier.Value = data["SupplierID"].ToString();
            this.txtCheque.Text = data["ChequeNumber"].ToString();
            this.ddType.SelectedValue = data["Type"].ToString();
            this.cbIsCheque.Checked = !string.IsNullOrWhiteSpace(this.txtCheque.Text);
            this.txtRemarks.Text = data["Remarks"].ToString();
            this.txtDate.Text = Convert.ToDateTime(data["Date"]).ToString("yyyy-MM-dd");

            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchCode='" + this.hiddenSelectedBranch.Value.ToString() + "'";

            DataRowView row = dv[0];

            this.txtSelectedBranch.Text = row["Branch_Name"].ToString();
        }

        private void CLEAR()
        {
            //Clear fields
            this.txtDate.Text = string.Empty;
            this.txtSupplier.Text = string.Empty;
            this.txtTIN.Text = string.Empty;
            this.txtInvoice.Text = string.Empty;
            this.txtVATAmount.Text = "0";
            this.txtNonVATAmount.Text = "0";
            this.txtVAT.Text = "0";
            this.txtTotal.Text = "0";
            this.txtTendered.Text = "0";
            this.txtUtilityFrom.Text = string.Empty;
            this.txtUtilityTo.Text = string.Empty;
            this.hiddenSelectedBranch.Value = string.Empty;
            this.hiddenSelectedSupplier.Value = string.Empty;
            this.txtSelectedBranch.Text = "No Branch Selected";
            this.txtRemarks.Text = string.Empty;
            this.txtAccountNumber.Text = string.Empty;

            //Set CSS classes to default
            this.txtDate.CssClass = "form-control";
            this.txtSupplier.CssClass = "form-control";
            this.txtTIN.CssClass = "form-control";
            this.txtInvoice.CssClass = "form-control";
            this.txtTotal.CssClass = "form-control";
            this.txtUtilityFrom.CssClass = "form-control";
            this.txtUtilityTo.CssClass = "form-control";
            this.txtInvoice.CssClass = "form-control";
            this.txtSelectedBranch.CssClass = "form-control";
        }

        private bool VALIDATE_EXPENSE_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.hiddenSelectedBranch.Value))
            {
                this.txtSelectedBranch.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtSelectedBranch.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtDate.Text))
            {
                this.txtDate.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtDate.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.hiddenSelectedSupplier.Value))
            {
                this.txtSupplier.CssClass += " is-invalid";
                this.txtTIN.CssClass += " is-invalid";
                is_valid = false;
            }
            else
            {
                this.txtSupplier.CssClass = "form-control";
                this.txtTIN.CssClass = "form-control";
            }

            if (string.IsNullOrWhiteSpace(this.txtInvoice.Text))
            {
                this.txtInvoice.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtInvoice.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtTotal.Text) || decimal.Parse(this.txtTotal.Text) <= 0)
            {
                this.txtTotal.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtTotal.CssClass = "form-control";

            if (ddType.SelectedIndex > 0)
            {
                if (string.IsNullOrWhiteSpace(this.txtUtilityTo.Text))
                {
                    this.txtUtilityTo.CssClass += " is-invalid";
                    is_valid = false;
                }
                else
                    this.txtUtilityTo.CssClass = "form-control";

                if (string.IsNullOrWhiteSpace(this.txtUtilityFrom.Text))
                {
                    this.txtUtilityFrom.CssClass += " is-invalid";
                    is_valid = false;
                }
                else
                    this.txtUtilityFrom.CssClass = "form-control";

                if (string.IsNullOrWhiteSpace(this.txtAccountNumber.Text))
                {
                    this.txtAccountNumber.CssClass += " is-invalid";
                    is_valid = false;
                }
                else
                    this.txtAccountNumber.CssClass = "form-control";
            }

            if (!is_valid)
                Show_Error_Toast("Error - Invalid Input");

            return is_valid;
        }

        private bool VALIDATE_NEW_SUPPLIER()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtNewSupplierName.Text) || string.IsNullOrWhiteSpace(this.txtNewSupplierTIN.Text)
                || string.IsNullOrWhiteSpace(this.txtNewSupplierAddress.Text))
                is_valid = false;


            return is_valid;
        }

        private void INSERT_PURCHASE_EXPENSE()
        {
            int type = int.Parse(this.ddType.SelectedValue);
            if (type == 1)
            {
                //Get the data for Insert
                string account_code = this.hiddenSelectedBranch.Value;
                int supplier_id = int.Parse(this.hiddenSelectedSupplier.Value);
                string invoice = this.txtInvoice.Text;
                string po_code = "Not applicable";
                decimal vatable = 0.00m;
                decimal.TryParse(this.txtVATAmount.Text, out vatable);
                decimal nonvat = 0.00m;
                decimal.TryParse(this.txtNonVATAmount.Text, out nonvat);
                decimal vat_amount = 0.00m;
                decimal.TryParse(this.txtVAT.Text, out vat_amount);
                decimal total_amount = 0.00m;
                decimal.TryParse(this.txtTotal.Text, out total_amount);
                string remarks = this.txtRemarks.Text;
                decimal amount_tendered = 0.00m;
                decimal.TryParse(this.txtTendered.Text, out amount_tendered);
                DateTime date = DateTime.Parse(this.txtDate.Text);
                string cheque_number = this.txtCheque.Text;

                //Insert the new Purchase Expense
                this.oBK.INSERT_PURCHASE_EXPENSE(account_code, supplier_id, invoice, po_code, type, vatable, nonvat, vat_amount, total_amount,
                    remarks, amount_tendered, date, cheque_number);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHEXPENSES.ToString(), "INSERT", Session["Username"].ToString());

                Show_Message_Toast("Successfully recorded Purchase expenses");
            }


        }

        private void INSERT_UTILITY_EXPENSE()
        {
            int type = int.Parse(this.ddType.SelectedValue);
            if (type > 1)
            {
                //Get the data for Insert
                string account_code = this.hiddenSelectedBranch.Value;
                int supplier_id = int.Parse(this.hiddenSelectedSupplier.Value);
                string invoice = this.txtInvoice.Text;
                string po_code = "Not Applicable";

                decimal vatable = 0.00m;
                decimal.TryParse(this.txtVATAmount.Text, out vatable);
                decimal nonvat = 0.00m;
                decimal.TryParse(this.txtNonVATAmount.Text, out nonvat);
                decimal vat_amount = 0.00m;
                decimal.TryParse(this.txtVAT.Text, out vat_amount);
                decimal total_amount = 0.00m;
                decimal.TryParse(this.txtTotal.Text, out total_amount);
                string remarks = this.txtRemarks.Text;
                decimal amount_tendered = 0.00m;
                decimal.TryParse(this.txtTendered.Text, out amount_tendered);
                DateTime date = DateTime.Today;
                DateTime.TryParse(this.txtDate.Text, out date);
                DateTime from_date = DateTime.Today;
                DateTime.TryParse(this.txtUtilityFrom.Text, out from_date);
                DateTime to_date = DateTime.Today;
                DateTime.TryParse(this.txtUtilityTo.Text, out to_date);
                string account_number = this.txtAccountNumber.Text == string.Empty ? "None specified" : this.txtAccountNumber.Text;
                string cheque_number = this.txtCheque.Text;

                //Insert the new Utility Expense
                this.oBK.INSERT_UTILITY_EXPENSE(account_code, supplier_id, invoice, po_code, type, vatable, nonvat, vat_amount, total_amount,
                    remarks, amount_tendered, date, from_date, to_date, account_number, cheque_number);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHEXPENSES.ToString(), "INSERT", Session["Username"].ToString());

                //Show Success Toast
                Show_Message_Toast("Successfully recorded Utility expenses");
            }

        }

        private void INSERT_NEW_SUPPLIER()
        {
            //Validate the form
            if (this.VALIDATE_NEW_SUPPLIER())
            {
                //Get the data for Insert
                string supplier_name = this.txtNewSupplierName.Text;
                string supplier_address = this.txtNewSupplierAddress.Text;
                string supplier_TIN = this.txtNewSupplierTIN.Text;
                bool is_vat = this.cbVAT.Checked;

                //Insert the new Supplier
                this.oMaster.INSERT_SUPPLIER_DATA(supplier_name,supplier_address,supplier_TIN,is_vat,string.Empty,string.Empty);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.SUPPLIERDATA.ToString(), "INSERT", Session["Username"].ToString());

                //Show Success toast
                Show_Message_Toast("Successfully added " + this.txtNewSupplierName.Text + " to the database");

                //Refresh the Supplier List
                this.DISPLAY_SUPPLIER_LIST();
            }
            //Display Error toast
            else
                Show_Error_Toast("Error - Invalid input. Please resubmit with complete information.");
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

        #region EVENTS

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            //int _branchID = Convert.ToInt32(r.Cells[0].Text);
            string branch_code = this.gvBranchList.DataKeys[r.RowIndex].Values[1].ToString();
            this.hiddenSelectedBranch.Value = branch_code;
            //ViewState["V_BRANCHID"] = Convert.ToInt32(r.Cells[0].Text);



            DataView data = oMaster.GET_BRANCH_LISTS().DefaultView;
            data.RowFilter = "BranchCode='" + branch_code + "'";


            if (data.Count > 0)
            {
                DataRowView row = data[0];

                this.txtSelectedBranch.Text = row["Branch_Name"].ToString();

                upForm.Update();

                this.DISPLAY_BRANCH_EXPENSES(this.hiddenSelectedBranch.Value);
                this.upExpenses.Update();

            //    //Disable the script to directly input on expenses form 10.19.2023
            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableNavs", "EnableNavs()", true);
            //    foreach (DataRowView dvr in dv)
            //    {
            //        //Display Details
            //        txtSelectedBranch.Text = dvr["Branch_Name"].ToString().Trim();

            }

            //    DISPLAY_UTILITIES(_branchCode);

            //    DISPLAY_EXPENSES_TYPE_LISTS();

            //    DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(_branchID);
            //}


        }

        protected void cbIsCheque_CheckedChanged(object sender, EventArgs e)
        {
            this.txtCheque.Enabled = this.cbIsCheque.Checked;
            if (!this.cbIsCheque.Checked)
                this.txtCheque.Text = string.Empty;
        }


        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            if (VALIDATE_EXPENSE_FORM())
            {
                if (int.Parse(ddType.SelectedValue.ToString()) == 1)
                    this.INSERT_PURCHASE_EXPENSE();
                else
                    this.INSERT_UTILITY_EXPENSE();

                //TODO Update Expense
            }
        }

        protected void lnkClear_Click(object sender, EventArgs e)
        {
            this.CLEAR();
        }

        protected void lnkSupplierSelect_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = int.Parse(this.gvSupplierList.DataKeys[r.RowIndex].Value.ToString());

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + _supplierID + "'";

            DataRowView row = dv[0];

            this.hiddenSelectedSupplier.Value = _supplierID.ToString();
            this.txtSupplier.Text = row["Supplier_Name"].ToString();
            this.txtTIN.Text = row["TIN"].ToString();

            ////TODO ViewState Is Supplier Non-VAT
            //if (dv.Count > 0)
            //{
            //    foreach (DataRowView dvr in dv)
            //    {

            //        //txtPurchaseSupplier.Text = dvr["Supplier_Name"].ToString();
            //        //txtPurchaseTIN.Text = dvr["TIN"].ToString();
            //        //upPurchase.Update();

            //    }
            //    //pPurchase.Visible = true;
            //    //pSupplier.Visible = false;
            //}
        }

        protected void ddType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddType.SelectedIndex > 0)
            {
                this.txtUtilityFrom.Enabled = true;
                this.txtUtilityTo.Enabled = true;
                this.txtAccountNumber.Enabled = true;
            }
            else
            {
                this.txtUtilityFrom.Enabled = false;
                this.txtUtilityTo.Enabled = false;
                this.txtAccountNumber.Enabled = false;
            }
        }

        protected void btnNewSupplierSubmit_Click(object sender, EventArgs e)
        {
            this.INSERT_NEW_SUPPLIER();
        }

        protected void btnSelectExpense_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int expense_id = int.Parse(this.gvExpenses.DataKeys[r.RowIndex].Value.ToString());

            this.DISPLAY_SELECTED_EXPENSE(expense_id);
            upForm.Update();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "<script>closeExpensesModal();</script>", false);
        }

        #endregion

        #region DEPRECIATED
        //protected void lnkRecordExpenses_Click(object sender, EventArgs e)
        //{
        //    DateTime dt;
        //    if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
        //    {
        //        txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

        //        Show_Message_Toast("Expense recorded.");
        //    }
        //    else
        //        Show_Error_Toast("Invalid input. Please check the highlighted fields.");
        //    //    DateTime dt;
        //    //    if(DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
        //    //    {
        //    //        txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

        //    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowToast", "ShowToast('Expenses recorded')", true);
        //    //    }
        //    //    else
        //    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ShowError", "ShowError('Invalid Input. Please check.')", true);
        //}

        //private void DISPLAY_UTILITIES(string _branchCode)
        //{
        //    DataTable dt = oBK.GET_BRANCH_DEFAULT_UTILITIES();
        //    DataView dv = dt.DefaultView;
        //    dv.RowFilter = "BranchCode = '" + _branchCode + "'";

        //    if (dv.Count > 0)
        //    {
        //        ddUtilitySupplier.DataSource = dv;
        //        ddUtilitySupplier.DataTextField = dv.Table.Columns["ProviderName"].ToString();
        //        ddUtilitySupplier.DataValueField = dv.Table.Columns["ID"].ToString();
        //        ddUtilitySupplier.DataBind();
        //        //ddUtilitySupplier.Items.Insert(0, new ListItem("*Select Provider"));
        //    }
        //    else
        //    {
        //        ddUtilitySupplier.DataSource = null;
        //        ddUtilitySupplier.DataBind();

        //        ViewState["SUPPLIERID"] = 0;
        //    }


        //}

        //private void DISPLAY_EXPENSES_TYPE_LISTS()
        //{
        //    DataTable dt = oBK.GET_EXPENSES_LISTS();
        //    ddExpenseType.DataSource = dt;
        //    ddExpenseType.DataTextField = dt.Columns["Expenses_Desc"].ToString();
        //    ddExpenseType.DataValueField = dt.Columns["ExpensesID"].ToString();
        //    ddExpenseType.DataBind();
        //    ddExpenseType.Items.Insert(0, new ListItem("-Select Expense Entry-"));
        //}


        //private void DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(int _branchID)
        //{
        //    DataTable dt = oBK.GET_BRANCH_EXPENSES_RECORD_LISTS(_branchID);
        //    if (dt.Rows.Count > 0)
        //    {
        //        //gvBranchExpensesRecordLists.DataSource = dt;
        //        //gvBranchExpensesRecordLists.DataBind();
        //    }
        //    else
        //    {
        //        //gvBranchExpensesRecordLists.DataSource = null;
        //        //gvBranchExpensesRecordLists.DataBind();
        //    }
        //}

        //private void CLEAR_UTILITY_INPUTS()
        //{
        //    //ddUtilitySupplier.SelectedIndex = 0;
        //    txtUtilityReceipt.Text = "";
        //    txtUtilityVATAmount.Text = "0";
        //    txtUtilityVAT.Text = "0";
        //    txtUtilityNonVATAmount.Text = "0";
        //    txtUtilityTotal.Text = "0";
        //    txtUtilityParticulars.Text = "";
        //    txtUtilityRemarks.Text = "";

        //    txtSupplierName1.Text = "";
        //    txtUtilityTIN.Text = "";
        //    txtUtilityReceipt.Text = "";

        //    ddExpenseType.SelectedIndex = 0;

        //    //ddUtilitySupplier.Focus();
        //    txtAppliedDate.Text = oBK.GetServerDate().ToShortDateString();
        //    txtUtilityFrom.Text = oBK.GetServerDate().ToShortDateString();
        //    txtUtilityTo.Text = oBK.GetServerDate().ToShortDateString();


        //}

        //private void CLEAR_PURCHASE_INPUTS()
        //{
        //    txtPurchaseSupplier.Text = String.Empty;
        //    txtPurchaseTIN.Text = String.Empty;
        //    txtPurchaseReceipt.Text = String.Empty;
        //    txtPurchaseVATAmount.Text = "0";
        //    txtPurchaseNonVATAmount.Text = "0";
        //    txtPurchaseVAT.Text = "0";
        //    txtPurchaseParticulars.Text = String.Empty;
        //}

        //protected void gvUtilitySupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    //foreach (GridViewRow row in gvExpensesLists.Rows)
        //    //{
        //    //    LinkButton edit = row.FindControl("lnkSupplierSelect") as LinkButton;
        //    //    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
        //    //}
        //}

        //protected void lnkUtilityClear_Click(object sender, EventArgs e)
        //{
        //    CLEAR_UTILITY_INPUTS();
        //}


        //protected void lnkPurchaseClear_Click(object sender, EventArgs e)
        //{
        //    //CLEAR_PURCHASE_INPUTS();
        //}

        //protected void ddExpenseType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddExpenseType.SelectedIndex == 2)
        //    {
        //        panelSupplierDropDown.Visible = false;
        //        panelSupplierNameText.Visible = true;
        //        txtUtilityTIN.ReadOnly = false;

        //        txtUtilityTo.Visible = false;
        //        txtUtilityFrom.Visible = false;
        //    }
        //    else
        //    {
        //        txtSupplierName1.Text = "";
        //        panelSupplierDropDown.Visible = true;
        //        panelSupplierNameText.Visible = false;
        //        txtUtilityTIN.ReadOnly = true;
        //        txtUtilityTIN.Text = "";
        //        txtUtilityTo.Visible = true;
        //        txtUtilityFrom.Visible = true;
        //    }

        //}

        //protected void ddUtilitySupplier_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    DataView dv = oBK.GET_BRANCH_DEFAULT_UTILITIES().DefaultView;
        //    dv.RowFilter = "ID ='" + Convert.ToInt32(ddUtilitySupplier.SelectedValue).ToString() + "'";
        //    if (dv.Count > 0)
        //    {
        //        foreach (DataRowView drv in dv)
        //        {
        //            txtUtilityTIN.Text = drv.Row["TIN"].ToString();
        //            ViewState["SUPPLIERID"] = Convert.ToInt32(ddUtilitySupplier.SelectedValue).ToString();
        //        }

        //    }
        //    else
        //    {
        //        txtUtilityTIN.Text = "";
        //    }
        //}

        //protected void lnkRecordUtility_Click(object sender, EventArgs e)
        //{
        //    //Add is-invalid CSS class appropriately
        //    if (String.IsNullOrWhiteSpace(txtSelectedBranch.Text))
        //        txtSelectedBranch.CssClass += " is-invalid";
        //    else
        //        txtSelectedBranch.CssClass = "form-control"; 

        //    if(double.Parse(txtUtilityTotal.Text) <= 0.00)
        //    {
        //        txtUtilityTotal.CssClass += " is-invalid";
        //    }
        //    else
        //        txtUtilityTotal.CssClass = "form-control";


        //    if(double.Parse(txtUtilityTotal.Text) > 0.00 && !String.IsNullOrWhiteSpace(txtSelectedBranch.Text))
        //    {
        //        //Save the transaction record
        //        //Save the transaction record
        //        oBK.INSERT_BRANCH_UTILITY_TRANS(Convert.ToInt32(ViewState["V_BRANCHID"]), Convert.ToInt32(ViewState["SUPPLIERID"]), txtSupplierName1.Text, txtUtilityTIN.Text, txtUtilityReceipt.Text,
        //                                         Convert.ToDouble(txtUtilityVATAmount.Text), Convert.ToDouble(txtUtilityNonVATAmount.Text),
        //                                         Convert.ToDouble(txtUtilityVAT.Text), Convert.ToDouble(txtUtilityTotal.Text),
        //                                         Convert.ToDateTime(txtAppliedDate.Text), Convert.ToDateTime(txtUtilityFrom.Text), Convert.ToDateTime(txtUtilityTo.Text), txtUtilityParticulars.Text, txtUtilityRemarks.Text, Convert.ToInt16(ddExpenseType.SelectedValue));

        //        CLEAR_UTILITY_INPUTS();

        //        //Success toast message
        //        Show_Message_Toast("Utility Expense transaction record successfully process.");
        //    }
        //    else
        //    {
        //        Show_Error_Toast("Invalid input. Please check the highlighted fields.");
        //    }

        //    //Condition before Saving
        //    if (Convert.ToDouble(txtUtilityTotal.Text) > 0)
        //    {


        //        //Save the transaction record
        //        oBK.INSERT_BRANCH_UTILITY_TRANS(Convert.ToInt32(ViewState["V_BRANCHID"]), Convert.ToInt32(ViewState["SUPPLIERID"]), txtSupplierName1.Text, txtUtilityTIN.Text, txtUtilityReceipt.Text,
        //                                         Convert.ToDouble(txtUtilityVATAmount.Text), Convert.ToDouble(txtUtilityNonVATAmount.Text),
        //                                         Convert.ToDouble(txtUtilityVAT.Text), Convert.ToDouble(txtUtilityTotal.Text),
        //                                         Convert.ToDateTime(txtAppliedDate.Text), Convert.ToDateTime(txtUtilityFrom.Text), Convert.ToDateTime(txtUtilityTo.Text), txtUtilityParticulars.Text, txtUtilityRemarks.Text, Convert.ToInt16(ddExpenseType.SelectedValue));

        //        //Refresh display record lists
        //        DISPLAY_BRANCH_EXPENSES_RECORD_LISTS(Convert.ToInt32(ViewState["V_BRANCHID"]));

        //        CLEAR_UTILITY_INPUTS();

        //        if (ddExpenseType.SelectedIndex == 1)
        //        {
        //            //Success toast message
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Utility Expense transaction record successfully process.');</script>", false);
        //        }
        //        else
        //        {
        //            //Success toast message
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Purchase transaction record successfully process.');</script>", false);

        //        }
        //    }

        //    else
        //    {
        //        //Success toast message
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastError('Zero Total Amount Expense not allowed.');</script>", false);

        //    }
        //}

        //protected void lnkSupplierSave_Click(object sender, EventArgs e)
        //{
        //    //txtSupplierTIN.Text = txtNewTin.Text;
        //    pPurchase.Visible = true;
        //    pSupplier.Visible = false;
        //}

        //protected void lnkNewSupplier_Click(object sender, EventArgs e)
        //{
        //    pSupplier.Visible = true;
        //    pPurchase.Visible = false;
        //}

        //protected void lnkSupplierBack_Click(object sender, EventArgs e)
        //{
        //    pPurchase.Visible = true;
        //    pSupplier.Visible = false;
        //}
        #endregion


    }
}