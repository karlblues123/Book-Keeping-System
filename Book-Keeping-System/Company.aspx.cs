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
    public partial class Company : System.Web.UI.Page
    {
        MasterC oMaster = new MasterC();
        BKC oBK = new BKC();
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_COMPANY_LISTS();
                this.DISPLAY_MONTH_FILTER();
                this.DISPLAY_YEAR_FILTER();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable data = oMaster.GET_COMPANY_LISTS();

            this.gvCompanyList.DataSource = data;
            this.gvCompanyList.DataBind();
        }

        private void DISPLAY_COMPANY_DETAILS()
        {
            DataView data = oMaster.GET_COMPANY_LISTS().DefaultView;

            data.RowFilter = "CompanyCode = '" + this.txtCompanyCode.Text + "'";

            if(data.Count > 0)
            {
                this.txtCompanyName.Text = data[0]["Company_Name"].ToString();
                this.txtCompanyAddress.Text = data[0]["CompanyAddress"].ToString();
                this.txtCompanyTIN.Text = data[0]["TIN"].ToString();
                this.txtCompanyCode.ReadOnly = true;
            }
        }

        private void DISPLAY_COMPANY_EXPENSES(string company_code)
        {
            //Get the list of expenses of a company as a DataView
            DataView data = oBK.GET_LIST_EXPENSES(company_code).DefaultView;

            //Apply the month and year filter
            data.RowFilter = "Date >= #" + ddMonthFilter.SelectedValue + "/01/" + ddYearFilter.SelectedValue +"# AND Date <= #"+
                ddMonthFilter.SelectedValue + "/" + DateTime.DaysInMonth(int.Parse(ddYearFilter.SelectedValue), int.Parse(ddMonthFilter.SelectedValue)).ToString() +
                "/"+ddYearFilter.SelectedValue+"#";

            //Display the output to the controls
            this.gvCompanyExpenses.DataSource = data;
            this.gvCompanyExpenses.DataBind();
        }

        private void DISPLAY_MONTH_FILTER()
        {
            for (int month = 1; month <= 12; month++)
            {
                string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(month);
                this.ddMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
            this.ddMonthFilter.SelectedIndex = DateTime.Today.Month-1;
        }

        private void DISPLAY_YEAR_FILTER()
        {
            for(int year = 2000; year <= 2030; year++)
            {
                this.ddYearFilter.Items.Add(new ListItem(year.ToString()));
            }
            this.ddYearFilter.SelectedValue = DateTime.Today.Year.ToString();
        }

        private void DISPLAY_EXPENSE_DETAILS()
        {
            if (!string.IsNullOrWhiteSpace(this.hiddenSelectedExpense.Value))
            {
                //Parse the Expense ID from the HiddenField control
                int id = int.Parse(this.hiddenSelectedExpense.Value);

                //Get the data from the database
                DataRow data = oBK.GET_SELECTED_EXPENSE(id).Rows[0];

                //Display the details to the controls
                this.txtSupplier.Text = data["Supplier_Name"].ToString();
                this.txtTIN.Text = data["TIN"].ToString();
                this.txtInvoice.Text = data["Invoice"].ToString();
                this.txtPO.Text = data["POCode"].ToString();
                this.txtType.Text = data["TypeName"].ToString();
                this.txtUtilityFrom.Text = data["FromDate"].ToString();
                this.txtUtilityTo.Text = data["ToDate"].ToString();
                this.txtAccountNumber.Text = data["AccountNumber"].ToString();
                this.txtVATAmount.Text = data["VATable"].ToString();
                this.txtNonVATAmount.Text = data["NonVAT"].ToString();
                this.txtVAT.Text = data["VATAmount"].ToString();
                this.txtTotal.Text = data["TotalAmount"].ToString();
                this.txtTendered.Text = data["AmountTendered"].ToString();
                this.txtCheque.Text = data["ChequeNumber"].ToString();
                this.txtRemarks.Text = data["Remarks"].ToString();
            }
            else
            {
                //Clear the details to the controls
                this.txtSupplier.Text = string.Empty;
                this.txtTIN.Text = string.Empty;
                this.txtInvoice.Text = string.Empty;
                this.txtPO.Text = string.Empty;
                this.txtType.Text = string.Empty;
                this.txtUtilityFrom.Text = string.Empty;
                this.txtUtilityTo.Text = string.Empty;
                this.txtAccountNumber.Text = string.Empty;
                this.txtVATAmount.Text = string.Empty;
                this.txtNonVATAmount.Text = string.Empty;
                this.txtVAT.Text = string.Empty;
                this.txtTotal.Text = string.Empty;
                this.txtTendered.Text = string.Empty;
                this.txtCheque.Text = string.Empty;
                this.txtRemarks.Text = string.Empty;
            }
        }

        private bool VALIDATE_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtCompanyCode.Text))
            {
                is_valid = false;
                this.txtCompanyCode.CssClass += " is-invalid";
            }
            else
                this.txtCompanyCode.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtCompanyName.Text))
            {
                is_valid = false;
                this.txtCompanyName.CssClass += " is_invalid";
            }
            else
                this.txtCompanyName.CssClass = "form-control";

            return is_valid;
        }

        private void CLEAR_FORM()
        {
            this.txtCompanyCode.Text = string.Empty;
            this.txtCompanyCode.ReadOnly = true;
            this.txtCompanyName.Text = string.Empty;
            this.txtCompanyAddress.Text = string.Empty;
            this.txtCompanyTIN.Text = string.Empty;
        }

        private void UPSERT_COMPANY_DETAILS()
        {
            //Get the data
            string company_code = this.txtCompanyCode.Text;
            string company_name = this.txtCompanyName.Text;
            string company_tin = this.txtCompanyTIN.Text;
            string company_address = this.txtCompanyAddress.Text;

            //Upsert the data
            this.oMaster.UPSERT_COMPANY(company_code, company_name, company_tin, company_address);

            //Insert an Audit Log
            this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.COMPANYDATA.ToString(), "UPDATE", Session["Username"].ToString());

            //Display Success toast
            this.Show_Message_Toast("Successfully saved " + company_name);

            //Refresh the list
            this.DISPLAY_COMPANY_LISTS();
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

        protected void lnkView_Click(object sender, EventArgs e)
        {
            this.pList.Visible = false;
            this.pDetails.Visible = true;

            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            this.txtCompanyCode.Text = this.gvCompanyList.DataKeys[r.RowIndex].Value.ToString();

            this.DISPLAY_COMPANY_DETAILS();
            this.DISPLAY_COMPANY_EXPENSES(this.txtCompanyCode.Text);
            this.ddMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            this.ddYearFilter.SelectedValue = DateTime.Today.Year.ToString();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            this.pDetails.Visible = false;
            this.pList.Visible = true;

            this.CLEAR_FORM();
        }

        protected void ddMonthFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_COMPANY_EXPENSES(this.txtCompanyCode.Text);
        }

        protected void ddYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_COMPANY_EXPENSES(this.txtCompanyCode.Text);
        }

        protected void hiddenSelectedExpense_ValueChanged(object sender, EventArgs e)
        {
            this.DISPLAY_EXPENSE_DETAILS();
        }

        protected void btnExpenseEdit_Click(object sender, EventArgs e)
        {
            Session["EditExpense"] = this.hiddenSelectedExpense.Value;
            Response.Redirect("CompanyExpenses.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_FORM())
                this.UPSERT_COMPANY_DETAILS();
            else
                this.Show_Error_Toast("Error - Invalid input. Please check the highlighted fields.");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            this.CLEAR_FORM();
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            this.pList.Visible = false;
            this.pDetails.Visible = true;
        }
        #endregion


    }
}