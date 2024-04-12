using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;

namespace Book_Keeping_System
{
    public partial class Branch : System.Web.UI.Page
    {
        MasterC oMaster = new MasterC();
        BKC oBK = new BKC();
        decimal chicken_total, atsara_total;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_MONTH_FILTER();
                this.DISPLAY_YEAR_FILTER();
                DISPLAY_BRANCH_LISTS();
                DISPLAY_COMPANY_LISTS();
                this.DISPLAY_SUPPLIER_LIST();
                //DISPLAY_SUPPLIER_LIST();
                //DISPLAY_SUPERVISOR_LISTS();
            }
            this.DISPLAY_SUPPLIER_LIST();
        }


        #region "Local UserDefined Function"

        private void DISPLAY_BRANCH_LISTS()
        {
            DataTable dt = oMaster.GET_BRANCH_LISTS();

            //Display sa gridview
            gvBranchList.DataSource = dt;
            gvBranchList.DataBind();
        }


        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable dt = oMaster.GET_COMPANY_LISTS();

            ddCompanyLists.DataSource = dt;
            ddCompanyLists.DataTextField = dt.Columns["Company_Name"].ToString();
            ddCompanyLists.DataValueField = dt.Columns["CompanyCode"].ToString();
            ddCompanyLists.DataBind();
        }

        private void DISPLAY_SUPERVISOR_LISTS()
        {
            DataTable dt = oMaster.GET_SUPERVISOR_LISTS();

            ddSupervisorLists.DataSource = dt;
            ddSupervisorLists.DataTextField = dt.Columns["Supervisor_Name"].ToString();
            ddSupervisorLists.DataValueField = dt.Columns["SupervisorID"].ToString();
            ddSupervisorLists.DataBind();

        }

        //private void DISPLAY_BRANCH_DEFAULT_UTILITIES(string _branchCode)
        //{
        //    DataView dv = oBK.GET_BRANCH_DEFAULT_UTILITIES().DefaultView;

        //    dv.RowFilter = "BranchCode ='" + _branchCode + "'";

        //    if (dv.Count > 0)
        //    {
        //        gvBranchDefaultUtilities.DataSource = dv;
        //    }
        //    else
        //    {
        //        gvBranchDefaultUtilities.DataSource = null;
        //    }

        //    gvBranchDefaultUtilities.DataBind();

        //}

        private void DISPLAY_MONTH_FILTER()
        {
            for (int month = 1; month <= 12; month++)
            {
                string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(month);
                ddSalesMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
                ddExpenseMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
            ddSalesMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            ddExpenseMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
        }

        private void DISPLAY_YEAR_FILTER()
        {
            for (int year = 2000; year <= 2030; year++)
            {
                ddSalesYearFilter.Items.Add(new ListItem(year.ToString()));
                ddExpenseYearFilter.Items.Add(new ListItem(year.ToString()));
            }
            ddSalesYearFilter.SelectedValue = DateTime.Today.Year.ToString();
            ddExpenseYearFilter.SelectedValue = DateTime.Today.Year.ToString();
        }

        private void DISPLAY_BRANCH_SALES(string branch_code)
        {
            chicken_total = 0.00m;
            atsara_total = 0.00m;
            DataView data = this.oBK.GET_BRANCH_SALES(branch_code).DefaultView;

            //Apply the month and year filter
            data.RowFilter = "Date >= #" + ddSalesMonthFilter.SelectedValue + "/01/" + ddSalesYearFilter.SelectedValue + "# AND Date <= #" +
                ddSalesMonthFilter.SelectedValue + "/" + DateTime.DaysInMonth(int.Parse(ddSalesYearFilter.SelectedValue), int.Parse(ddSalesMonthFilter.SelectedValue)).ToString() +
                "/" + ddSalesYearFilter.SelectedValue + "#";

            this.lblNoSales.Visible = !(data.Count > 0);
            this.gvBranchSales.DataSource = data;
            this.gvBranchSales.DataBind();
        }

        private void DISPLAY_BRANCH_EXPENSES(string branch_code)
        {
            //Get the list of expenses of a company as a DataView
            DataView data = oBK.GET_LIST_EXPENSES(branch_code).DefaultView;

            //Apply the month and year filter
            data.RowFilter = "Date >= #" + ddExpenseMonthFilter.SelectedValue + "/01/" + ddExpenseYearFilter.SelectedValue + "# AND Date <= #" +
                ddExpenseMonthFilter.SelectedValue + "/" + DateTime.DaysInMonth(int.Parse(ddExpenseYearFilter.SelectedValue), int.Parse(ddExpenseMonthFilter.SelectedValue)).ToString() +
                "/" + ddExpenseYearFilter.SelectedValue + "#";

            //Display the output to the controls
            gvBranchExpenses.DataSource = data;
            gvBranchExpenses.DataBind();
            this.lblNoExpenses.Visible = !(data.Count > 0);
        }

        private void DISPLAY_EXPENSE_DETAILS()
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedExpense.Value))
            {
                //Parse the Expense ID from the HiddenField control
                int id = int.Parse(this.hiddenSelectedExpense.Value);

                //Get the data from the database
                DataRow data = oBK.GET_SELECTED_EXPENSE(id).Rows[0];

                //Display the details to the controls
                this.txtSupplier.Text = data["Supplier_Name"].ToString();
                this.txtTIN.Text = data["TIN"].ToString();
                this.txtInvoice.Text = data["Invoice"].ToString();
                this.txtType.Text = data["TypeName"].ToString();
                this.txtUtilityFrom.Text = data["FromDate"].ToString();
                this.txtUtilityTo.Text = data["ToDate"].ToString();
                this.txtAccountNumber.Text = data["AccountNumber"].ToString();
                this.txtVATAmount.Text = data["VATable"].ToString();
                this.txtNonVATAmount.Text = data["NonVAT"].ToString();
                this.txtVAT.Text = data["VATAmount"].ToString();
                this.txtTotal.Text = data["TotalAmount"].ToString();
                this.txtTendered.Text = data["AmountTendered"].ToString();
                this.txtRemarks.Text = data["Remarks"].ToString();
            }
            else
            {
                //Clear the details to the controls
                this.txtSupplier.Text = string.Empty;
                this.txtTIN.Text = string.Empty;
                this.txtInvoice.Text = string.Empty;
                this.txtType.Text = string.Empty;
                this.txtUtilityFrom.Text = string.Empty;
                this.txtUtilityTo.Text = string.Empty;
                this.txtAccountNumber.Text = string.Empty;
                this.txtVATAmount.Text = string.Empty;
                this.txtNonVATAmount.Text = string.Empty;
                this.txtVAT.Text = string.Empty;
                this.txtTotal.Text = string.Empty;
                this.txtTendered.Text = string.Empty;
                this.txtRemarks.Text = string.Empty;
            }
        }

        private void DISPLAY_BRANCH_RENTAL_CONTRACTS()
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedBranch.Value))
            {
                DataTable data = this.oBK.GET_RENTAL_CONTRACTS(this.hiddenSelectedBranch.Value);

                this.lblNoContracts.Visible = !(data.Rows.Count > 0);
                this.gvRentalContract.DataSource = data;
                this.gvRentalContract.DataBind();
            }
        }

        private void CLEAR_BASIC()
        {
            txtBranchName.Text = string.Empty;
            txtBranch_Address.Text = string.Empty;
            //ddSupervisorLists.SelectedIndex = 0;
            ddCompanyLists.SelectedIndex = 0;

            this.hiddenSelectedBranch.Value = string.Empty;

            //ViewState["V_BRANCHCODE"] = "";

        }

        private void CLEAR_CONTRACT_FORM()
        {
            this.txtLessor.Text = string.Empty;
            this.txtLessorTIN.Text = string.Empty;
            this.txtFromContract.Text = string.Empty;
            this.txtToContract.Text = string.Empty;
            this.txtContractRemarks.Text = string.Empty;
            this.hiddenSelectedLessor.Value = string.Empty;

            this.txtLessor.CssClass = "form-control";
            this.txtLessorTIN.CssClass = "form-control";
            this.txtFromContract.CssClass = "form-control";
            this.txtToContract.CssClass = "form-control";
        }

        private void DISPLAY_SUPPLIER_LIST()
        {
            DataTable data = this.oMaster.GET_SUPPLIER_LISTS();

            this.gvSupplierList.DataSource = data;
            this.gvSupplierList.DataBind();

            foreach (GridViewRow row in this.gvSupplierList.Rows)
            {
                LinkButton btn = row.FindControl("lnkSupplierSelect") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);
            }
        }

        //private void DISPLAY_SUPPLIER_LIST()
        //{
        //    DataTable dt = oMaster.GET_SUPPLIER_LISTS();

        //    //Display Utility Suppliers in the list
        //    gvUtilitySupplierList.DataSource = dt;
        //    gvUtilitySupplierList.DataBind();

        //}

        private bool VALIDATE_CONTRACT_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrEmpty(this.hiddenSelectedLessor.Value))
            {
                this.txtLessor.CssClass += " is-invalid";
                this.txtLessorTIN.CssClass += " is-invalid";
                is_valid = false;
            }
            else
            {
                this.txtLessor.CssClass = "form-control";
                this.txtLessorTIN.CssClass = "form-control";
            }

            if (string.IsNullOrEmpty(this.txtLessee.Text))
            {
                this.txtLessee.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtLessee.CssClass = "form-control";

            if (string.IsNullOrEmpty(this.txtFromContract.Text))
            {
                this.txtFromContract.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtFromContract.CssClass = "form-control";

            if (string.IsNullOrEmpty(this.txtToContract.Text))
            {
                this.txtToContract.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtToContract.CssClass = "form-control";

            return is_valid;
        }

        private void INSERT_RENTAL_CONTRACT()
        {
            int lessor = int.Parse(this.hiddenSelectedLessor.Value);
            string lessee = this.txtLessee.Text;
            DateTime from_date = DateTime.Parse(this.txtFromContract.Text);
            DateTime to_date = DateTime.Parse(this.txtToContract.Text);
            string branch_code = this.hiddenSelectedBranch.Value;
            string remarks = this.txtContractRemarks.Text;


            this.oBK.INSERT_BRANCH_RENTAL_CONTRACT(lessor, lessee, from_date, to_date, branch_code, remarks);

            this.Show_Message_Toast("Successfully added a new Contract for " + this.txtBranchName.Text + " branch with " + this.txtLessor);
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
            int _branchID = Convert.ToInt32(this.gvBranchList.DataKeys[r.RowIndex].Values[0].ToString());
            //ViewState["V_SUPPLIERID"] = _supplierID;

            string _branchCode = this.gvBranchList.DataKeys[r.RowIndex].Values[1].ToString();
            this.hiddenSelectedBranch.Value = _branchCode;
            //ViewState["V_BRANCHCODE"] = _branchCode ;


            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchID='" + _branchID + "'";


            if (dv.Count > 0)
            {
              
                //Show the entry field
                panelBranchLists.Visible = false;
                pBranchInputForm.Visible = true;

                this.DISPLAY_BRANCH_EXPENSES(this.hiddenSelectedBranch.Value);
                this.DISPLAY_BRANCH_RENTAL_CONTRACTS();

                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtBranchName.Text = dvr["Branch_Name"].ToString().Trim();
                    //ddSupervisorLists.SelectedValue = dvr["SupervisorID"].ToString();
                    ddCompanyLists.SelectedValue = dvr["CompanyCode"].ToString();
                    this.txtBranchTIN.Text = dvr["BranchTIN"].ToString();
                    //txtSupplierTIN.Text = dvr["S_TIN"].ToString();
                    //cbVAT.Checked = (bool)dvr["IsVat"];

                }

                //ViewState["V_ACTION"] = 1; //This will hold the option for action.

                //Calling display function for default utilities
                //DISPLAY_BRANCH_DEFAULT_UTILITIES(_branchCode);

                this.DISPLAY_BRANCH_SALES(_branchCode);
            }
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            panelBranchLists.Visible = true;
            pBranchInputForm.Visible = false;
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            panelBranchLists.Visible = false;
            pBranchInputForm.Visible = true;

            CLEAR_BASIC();

            txtBranchName.Focus();
        }

       
        //protected void lnkAddNewProvider_Click(object sender, EventArgs e)
        //{
            
        //    pProviderList.Visible = false;
        //    pNewProvider.Visible = true;

        //}

        //protected void lnkProviderBack_Click(object sender, EventArgs e)
        //{
        //    pNewProvider.Visible = false;
        //    pProviderList.Visible = true;

        //    //Clear Fields for provider
        //    txtProvider.Text = "";
        //    txtProviderAcctNumber.Text = "";
        //    txtTIN.Text = "";
        //    txtRemarks.Text = "";
        //}

        //protected void lnkSaveProvider_Click(object sender, EventArgs e)
        //{
        //    if (!string.IsNullOrEmpty(txtProvider.Text))
        //    {
        //        oBK.INSERT_DEFAULT_BRANCH_UTILITIES(ViewState["V_BRANCHCODE"].ToString(), txtProvider.Text.Trim(), txtProviderAcctNumber.Text, txtTIN.Text, txtRemarks.Text);

        //        DISPLAY_BRANCH_DEFAULT_UTILITIES(ViewState["V_BRANCHCODE"].ToString());

               

        //        //Success toast message
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('New Provider Added.');</script>", false);

        //        //call event of back button
        //        lnkProviderBack_Click(sender, e);
        //    }
        //}

        protected void lnkUtilitySelect_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = Convert.ToInt32(r.Cells[0].Text);

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + _supplierID + "'";

            if (dv.Count > 0)
            {
                foreach (DataRowView dvr in dv)
                {
                    //txtProvider.Text = dvr["Supplier_Name"].ToString();
                    //txtTIN.Text = dvr["TIN"].ToString();

                }
                
            }
        }

        //protected void gvUtilitySupplierList_RowCreated(object sender, GridViewRowEventArgs e)
        //{
        //    foreach (GridViewRow row in gvUtilitySupplierList.Rows)
        //    {
        //        LinkButton edit = row.FindControl("lnkUtilitySelect") as LinkButton;
        //        ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
        //    }
        //}

        protected void ddSalesMonthFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_BRANCH_SALES(this.hiddenSelectedBranch.Value);
        }

        protected void ddSalesYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_BRANCH_SALES(this.hiddenSelectedBranch.Value);
        }

        protected void gvBranchSales_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label total = (Label)e.Row.FindControl("lblChickenOverallTotal");

                if(total != null)
                {
                    total.Text = string.Format("{0:n}", chicken_total);
                }

                total = (Label)e.Row.FindControl("lblAtsaraOverallTotal");

                if (total != null)
                {
                    total.Text = string.Format("{0:n}", atsara_total);
                }
            }
        }

        protected void ddExpenseMonthFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_BRANCH_EXPENSES(this.hiddenSelectedBranch.Value);
        }

        protected void ddExpenseYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_BRANCH_EXPENSES(this.hiddenSelectedBranch.Value);
        }

        protected void hiddenSelectedExpense_ValueChanged(object sender, EventArgs e)
        {
            this.DISPLAY_EXPENSE_DETAILS();
        }

        protected void btnNewContract_Click(object sender, EventArgs e)
        {
            this.pContractList.Visible = false;
            this.pContractForm.Visible = true;
        }

        protected void btnCancelNewContract_Click(object sender, EventArgs e)
        {
            this.pContractForm.Visible = false;
            this.pContractList.Visible = true;

            this.CLEAR_CONTRACT_FORM();
        }

        protected void lnkSupplierSelect_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = int.Parse(this.gvSupplierList.DataKeys[r.RowIndex].Value.ToString());

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + _supplierID + "'";

            DataRowView row = dv[0];

            this.hiddenSelectedLessor.Value = _supplierID.ToString();
            this.txtLessor.Text = row["Supplier_Name"].ToString();
            this.txtLessorTIN.Text = row["TIN"].ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "<script>closeSupplierModal();</script>", false);
            upRental.Update();
        }

        protected void btnSaveNewContract_Click(object sender, EventArgs e)
        {
            if (VALIDATE_CONTRACT_FORM())
                this.INSERT_RENTAL_CONTRACT();
            else
                this.Show_Error_Toast("Error - Invalid Input. Please check the highlighted fields.");
            
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {

        }

        protected void gvBranchSales_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[2];

                DataBoundLiteralControl boundControl = (DataBoundLiteralControl)cell.Controls[0];

                chicken_total += decimal.Parse(boundControl.Text);

                cell = e.Row.Cells[3];

                boundControl = (DataBoundLiteralControl)cell.Controls[0];

                atsara_total += decimal.Parse(boundControl.Text);
            }
        }
        #endregion


    }
}