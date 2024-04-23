﻿using System;
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
        BKC oBK = new BKC();
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                this.DISPLAY_EXPENSE_TYPES();
                this.DISPLAY_COMPANY_LISTS();
                this.DISPLAY_SUPPLIER_LIST();
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
        private void DISPLAY_EXPENSE_TYPES()
        {
            DataTable data = oBK.GET_EXPENSE_TYPES();

            this.ddType.DataTextField = "TypeName";
            this.ddType.DataValueField = "ID";
            this.ddType.DataSource = data;
            this.ddType.DataBind();
        }


        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable data = this.oMaster.GET_COMPANY_LISTS();

            this.gvCompany.DataSource = data;
            this.gvCompany.DataBind();
        }

        private void DISPLAY_SUPPLIER_LIST()
        {
            DataTable data = this.oMaster.GET_SUPPLIER_LISTS();

            this.gvSupplierList.DataSource = data;
            this.gvSupplierList.DataBind();

        }

        private void DISPLAY_COMPANY_EXPENSES(string company_code)
        {   
            //Get the list of expenses of a company
            DataTable data = this.oBK.GET_LIST_EXPENSES(company_code);

            //Display the output to the controls
            this.gvExpenses.DataSource = data;
            this.gvExpenses.DataBind();
        }

        private void CLEAR_INPUT()
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
            this.hiddenSelectedCompany.Value = string.Empty;
            this.hiddenSelectedSupplier.Value = string.Empty;
            this.hiddenSelectedExpense.Value = string.Empty;
            this.cbIsCheque.Checked = false;
            this.txtCheque.Enabled = false;
            this.txtSelectedCompany.Text = "No Company Selected";
            this.txtRemarks.Text = string.Empty;
            this.txtAccountNumber.Text = string.Empty;

            this.txtUtilityFrom.Enabled = false;
            this.txtUtilityTo.Enabled = false;
            this.txtAccountNumber.Enabled = false;
            this.cbIsCheque.Checked = false;
            this.txtCheque.Enabled = this.cbIsCheque.Checked;

            //Set CSS classes to default
            this.txtDate.CssClass = "form-control";
            this.txtSupplier.CssClass = "form-control";
            this.txtTIN.CssClass = "form-control";
            this.txtInvoice.CssClass = "form-control";
            this.txtTotal.CssClass = "form-control";
            this.txtCheque.CssClass = "form-control";
            this.txtUtilityFrom.CssClass = "form-control";
            this.txtUtilityTo.CssClass = "form-control";
            this.txtInvoice.CssClass = "form-control";
            this.txtSelectedCompany.CssClass = "form-control";

            this.gvExpenses.DataSource = null;
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
            this.txtUtilityFrom.Text = Convert.ToDateTime(data["FromDate"].ToString()).ToString("yyyy-MM-dd");
            this.txtUtilityTo.Text = Convert.ToDateTime(data["ToDate"].ToString()).ToString("yyyy-MM-dd");
            this.txtAccountNumber.Text = data["AccountNumber"].ToString();
            this.hiddenSelectedCompany.Value = data["AccountCode"].ToString();
            this.hiddenSelectedSupplier.Value = data["SupplierID"].ToString();
            this.txtCheque.Text = data["ChequeNumber"].ToString();
            this.ddType.SelectedValue = data["Type"].ToString();
            this.cbIsCheque.Checked = !string.IsNullOrWhiteSpace(this.txtCheque.Text);
            this.txtCheque.Enabled = this.cbIsCheque.Checked;
            this.txtRemarks.Text = data["Remarks"].ToString();
            this.txtDate.Text = Convert.ToDateTime(data["Date"]).ToString("yyyy-MM-dd");

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

            DataView dv = oMaster.GET_COMPANY_LISTS().DefaultView;
            dv.RowFilter = "CompanyCode='" + this.hiddenSelectedCompany.Value.ToString() + "'";

            DataRowView row = dv[0];

            this.txtSelectedCompany.Text = row["Company_Name"].ToString();
        }

        private bool VALIDATE_EXPENSE_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.hiddenSelectedCompany.Value))
            {
                this.txtSelectedCompany.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtSelectedCompany.CssClass = "form-control";

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

            if (this.cbIsCheque.Checked && string.IsNullOrWhiteSpace(this.txtCheque.Text))
            {
                this.txtCheque.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtCheque.CssClass = "form-control";

            if(ddType.SelectedIndex > 0)
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

        private void UPSERT_PURCHASE_EXPENSE()
        {
            int type = int.Parse(this.ddType.SelectedValue);
            if(type == 1)
            {
                //Get the data
                string account_code = this.hiddenSelectedCompany.Value;
                int supplier_id = int.Parse(this.hiddenSelectedSupplier.Value);
                string invoice = this.txtInvoice.Text;
                string po_code = this.txtPO.Text == string.Empty ? "None Stated" : this.txtPO.Text;
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

                if (string.IsNullOrWhiteSpace(this.hiddenSelectedExpense.Value))
                {
                    //Insert the new Purchase Expense
                    this.oBK.INSERT_PURCHASE_EXPENSE(account_code, supplier_id, invoice, po_code, type, vatable, nonvat, vat_amount, total_amount,
                        remarks, amount_tendered, date, cheque_number);

                    //Insert an Audit Log
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.COMPANYEXPENSES.ToString(), "INSERT", Session["Username"].ToString());

                    //Show Success Toast
                    Show_Message_Toast("Successfully recorded Purchase expense");
                }
                else
                {
                    //Get the ID of the Expense
                    int expense_id = int.Parse(this.hiddenSelectedExpense.Value);

                    //Update the Expense
                    this.oBK.UPDATE_PURCHASE_EXPENSE(expense_id, invoice, po_code, vatable, nonvat, vat_amount, total_amount, 
                        remarks, amount_tendered, date);

                    //Insert an Audit Log
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.COMPANYEXPENSES.ToString(), "UPDATE", Session["Username"].ToString());

                    //Show Success Toast
                    this.Show_Message_Toast("Successfully updated this expense");
                }

            }

            
        }

        private void UPSERT_UTILITY_EXPENSE()
        {
            int type = int.Parse(this.ddType.SelectedValue);
            if(type > 1)
            {
                //Get the data
                string account_code = this.hiddenSelectedCompany.Value;
                int supplier_id = int.Parse(this.hiddenSelectedSupplier.Value);
                string invoice = this.txtInvoice.Text;
                string po_code = this.txtPO.Text == string.Empty ? "None Stated" : this.txtPO.Text;

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

                if (string.IsNullOrWhiteSpace(this.hiddenSelectedExpense.Value))
                {
                    //Insert the new Utility Expense
                    this.oBK.INSERT_UTILITY_EXPENSE(account_code, supplier_id, invoice, po_code, type, vatable, nonvat, vat_amount, total_amount,
                        remarks, amount_tendered, date, from_date, to_date, account_number, cheque_number);

                    //Insert an Audit Log
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.COMPANYEXPENSES.ToString(), "INSERT", Session["Username"].ToString());

                    //Show Success toast
                    Show_Message_Toast("Successfully recorded Utility expense");
                }
                else
                {
                    //Get the ID of the Expense
                    int expense_id = int.Parse(this.hiddenSelectedExpense.Value);

                    //Update the Expense
                    this.oBK.UPDATE_UTILITY_EXPENSE(expense_id, invoice, po_code, vatable, nonvat, vat_amount, total_amount, remarks, 
                        amount_tendered, date, from_date, to_date, account_number);

                    //Insert an Audit Log
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.COMPANYEXPENSES.ToString(), "UPDATE", Session["Username"].ToString());

                    //Show Success toast
                    Show_Message_Toast("Successfully updated this expense");
                }
                
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
                this.oMaster.INSERT_SUPPLIER_DATA(supplier_name, supplier_address, supplier_TIN, is_vat, string.Empty, string.Empty);

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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('"+ msg +"');</script>", false);
        }

        #endregion

        #region EVENTS
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
        }

        protected void ddType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Toggle the Utility fields
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

        protected void lnkSelectCompany_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = int.Parse(this.gvCompany.DataKeys[r.RowIndex].Value.ToString());

            DataView dv = oMaster.GET_COMPANY_LISTS().DefaultView;
            dv.RowFilter = "CompanyID='" + _supplierID + "'";

            DataRowView row = dv[0];

            this.hiddenSelectedCompany.Value = row["CompanyCode"].ToString();
            this.txtSelectedCompany.Text = row["Company_Name"].ToString();
            this.DISPLAY_COMPANY_EXPENSES(this.hiddenSelectedCompany.Value);
            this.upForm.Update();
            this.upExpenses.Update();
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            if (VALIDATE_EXPENSE_FORM())
            {
                if (int.Parse(ddType.SelectedValue.ToString()) == 1)
                    this.UPSERT_PURCHASE_EXPENSE();
                else
                    this.UPSERT_UTILITY_EXPENSE();

            }
        }

        protected void cbIsCheque_CheckedChanged(object sender, EventArgs e)
        {
            this.txtCheque.Enabled = this.cbIsCheque.Checked;
            if (!this.cbIsCheque.Checked)
                this.txtCheque.Text = string.Empty;
        }

        protected void lnkClear_Click(object sender, EventArgs e)
        {
            this.CLEAR_INPUT();
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


    }
}