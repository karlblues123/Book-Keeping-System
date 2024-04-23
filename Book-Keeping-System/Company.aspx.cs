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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_COMPANY_LISTS();
                DISPLAY_MONTH_FILTER();
                DISPLAY_YEAR_FILTER();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable data = oMaster.GET_COMPANY_LISTS();

            gvCompanyList.DataSource = data;
            gvCompanyList.DataBind();
        }

        private void DISPLAY_COMPANY_DETAILS()
        {
            DataView data = oMaster.GET_COMPANY_LISTS().DefaultView;

            data.RowFilter = "CompanyCode = '" + this.hiddenSelectedCompany.Value + "'";

            if(data.Count > 0)
            {
                this.txtCompanyName.Text = data[0]["Company_Name"].ToString();
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
            gvCompanyExpenses.DataSource = data;
            gvCompanyExpenses.DataBind();
        }

        private void DISPLAY_MONTH_FILTER()
        {
            for (int month = 1; month <= 12; month++)
            {
                string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(month);
                ddMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
            ddMonthFilter.SelectedIndex = DateTime.Today.Month-1;
        }

        private void DISPLAY_YEAR_FILTER()
        {
            for(int year = 2000; year <= 2030; year++)
            {
                ddYearFilter.Items.Add(new ListItem(year.ToString()));
            }
            ddYearFilter.SelectedValue = DateTime.Today.Year.ToString();
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
        #endregion

        #region EVENTS

        protected void lnkView_Click(object sender, EventArgs e)
        {
            pList.Visible = false;
            pDetails.Visible = true;

            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            this.hiddenSelectedCompany.Value = this.gvCompanyList.DataKeys[r.RowIndex].Value.ToString();

            this.DISPLAY_COMPANY_DETAILS();
            this.DISPLAY_COMPANY_EXPENSES(this.hiddenSelectedCompany.Value);
            ddMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            ddYearFilter.SelectedValue = DateTime.Today.Year.ToString();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            pDetails.Visible = false;
            pList.Visible = true;
        }

        protected void ddMonthFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            DISPLAY_COMPANY_EXPENSES(this.hiddenSelectedCompany.Value);
        }

        protected void ddYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            DISPLAY_COMPANY_EXPENSES(this.hiddenSelectedCompany.Value);
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
        #endregion


    }
}