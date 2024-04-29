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
        xSysC oSys = new xSysC();
        decimal chicken_total, atsara_total; //Used for displaying total Sales

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_MONTH_FILTER();
                this.DISPLAY_YEAR_FILTER();
                this.DISPLAY_BRANCH_LISTS();
                this.DISPLAY_COMPANY_LISTS();
                this.DISPLAY_SUPPLIER_LIST();
                //DISPLAY_SUPPLIER_LIST();
                //DISPLAY_SUPERVISOR_LISTS();
            }
            this.DISPLAY_SUPPLIER_LIST();
        }


        #region "Local UserDefined Function"

        private void DISPLAY_BRANCH_LISTS()
        {
            DataTable data = this.oMaster.GET_BRANCH_LISTS();

            this.gvBranchList.DataSource = data;
            this.gvBranchList.DataBind();
        }


        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable data = this.oMaster.GET_COMPANY_LISTS();

            this.ddCompanyLists.DataSource = data;
            this.ddCompanyLists.DataTextField = data.Columns["Company_Name"].ToString();
            this.ddCompanyLists.DataValueField = data.Columns["CompanyCode"].ToString();
            this.ddCompanyLists.DataBind();
        }

        private void DISPLAY_SUPERVISOR_LISTS()
        {
            DataTable data = this.oMaster.GET_SUPERVISOR_LISTS();

            this.ddSupervisorLists.DataSource = data;
            this.ddSupervisorLists.DataTextField = data.Columns["Supervisor_Name"].ToString();
            this.ddSupervisorLists.DataValueField = data.Columns["SupervisorID"].ToString();
            this.ddSupervisorLists.DataBind();

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
                this.ddSalesMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
                this.ddExpenseMonthFilter.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
            this.ddSalesMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            this.ddExpenseMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
        }

        private void DISPLAY_YEAR_FILTER()
        {
            for (int year = 2000; year <= 2030; year++)
            {
                this.ddSalesYearFilter.Items.Add(new ListItem(year.ToString()));
                this.ddExpenseYearFilter.Items.Add(new ListItem(year.ToString()));
            }
            this.ddSalesYearFilter.SelectedValue = DateTime.Today.Year.ToString();
            this.ddExpenseYearFilter.SelectedValue = DateTime.Today.Year.ToString();
        }

        private void DISPLAY_BRANCH_DETAILS()
        {
            //Get the selected Branch based on its Branch Code
            DataView data = this.oMaster.GET_BRANCH_LISTS().DefaultView;
            data.RowFilter = "BranchCode='" + this.txtBranchCode.Text + "'";

            //Display the basic details to the fields
            this.txtBranchName.Text = data[0]["Branch_Name"].ToString();
            this.txtBranchCode.ReadOnly = (!string.IsNullOrWhiteSpace(data[0]["BranchCode"].ToString()));
            this.txtBranch_Address.Text = data[0]["Branch_Address"].ToString();
            this.txtBranchTIN.Text = data[0]["BranchTIN"].ToString();
            this.ddCompanyLists.SelectedValue = data[0]["CompanyCode"].ToString();
            this.cbOpen.Checked = bool.Parse(data[0]["IsActive"].ToString());
        }

        private void DISPLAY_BRANCH_SALES()
        {
            chicken_total = 0.00m;
            atsara_total = 0.00m;
            DataView data = this.oBK.GET_BRANCH_SALES(this.txtBranchCode.Text.ToString()).DefaultView;

            //Apply the month and year filter
            data.RowFilter = "Date >= #" + ddSalesMonthFilter.SelectedValue + "/01/" + ddSalesYearFilter.SelectedValue + "# AND Date <= #" +
                ddSalesMonthFilter.SelectedValue + "/" + DateTime.DaysInMonth(int.Parse(ddSalesYearFilter.SelectedValue), int.Parse(ddSalesMonthFilter.SelectedValue)).ToString() +
                "/" + ddSalesYearFilter.SelectedValue + "#";

            this.gvBranchSales.DataSource = data;
            this.gvBranchSales.DataBind();
        }

        private void DISPLAY_BRANCH_EXPENSES()
        {
            //Get the list of expenses of a company as a DataView
            DataView data = oBK.GET_LIST_EXPENSES(this.txtBranchCode.Text.ToString()).DefaultView;

            //Apply the month and year filter
            data.RowFilter = "Date >= #" + ddExpenseMonthFilter.SelectedValue + "/01/" + ddExpenseYearFilter.SelectedValue + "# AND Date <= #" +
                ddExpenseMonthFilter.SelectedValue + "/" + DateTime.DaysInMonth(int.Parse(ddExpenseYearFilter.SelectedValue), int.Parse(ddExpenseMonthFilter.SelectedValue)).ToString() +
                "/" + ddExpenseYearFilter.SelectedValue + "#";

            //Display the output to the controls
            this.gvBranchExpenses.DataSource = data;
            this.gvBranchExpenses.DataBind();
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
            if (!string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
            {
                DataTable data = this.oBK.GET_RENTAL_CONTRACTS(this.txtBranchCode.Text);

                this.gvRentalContract.DataSource = data;
                this.gvRentalContract.DataBind();
            }
        }

        private void DISPLAY_BRANCH_RENTAL_CONTRACT_DETAILS()
        {
            DataView data = this.oBK.GET_RENTAL_CONTRACTS(this.txtBranchCode.Text).DefaultView;
            data.RowFilter = "ID = " + this.hiddenSelectedContract.Value;

            this.hiddenSelectedLessor.Value = data[0]["Lessor"].ToString();

            DataView lessor = this.oMaster.GET_SUPPLIER_LISTS().DefaultView;
            lessor.RowFilter = "SupplierID = " + this.hiddenSelectedLessor.Value;

            this.txtLessor.Text = lessor[0]["Supplier_Name"].ToString();
            this.txtLessorTIN.Text = lessor[0]["TIN"].ToString();

            //Display the data
            this.txtLessee.Text = data[0]["Lessee"].ToString();
            this.txtContractRemarks.Text = data[0]["Remarks"].ToString();
            this.txtFromContract.Text = DateTime.Parse(data[0]["FromDate"].ToString()).ToString("yyyy-MM-dd");
            this.txtToContract.Text = DateTime.Parse(data[0]["ToDate"].ToString()).ToString("yyyy-MM-dd");

            this.pContractList.Visible = false;
            this.pContractForm.Visible = true;
            this.upRental.Update();
        }

        private void CLEAR_BASIC()
        {
            this.txtBranchName.Text = string.Empty;
            this.txtBranch_Address.Text = string.Empty;
            this.txtBranchCode.Text = string.Empty;
            this.txtBranchCode.ReadOnly = false;
            this.txtBranchTIN.Text = string.Empty;
            //ddSupervisorLists.SelectedIndex = 0;
            this.ddCompanyLists.SelectedIndex = 0;
            this.cbOpen.Checked = false;

            this.txtBranchCode.Text = string.Empty;

            this.ddSalesMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            this.ddExpenseMonthFilter.SelectedIndex = DateTime.Today.Month - 1;
            this.ddSalesYearFilter.SelectedValue = DateTime.Today.Year.ToString();
            this.ddExpenseYearFilter.SelectedValue = DateTime.Today.Year.ToString();
            //ViewState["V_BRANCHCODE"] = "";

        }

        private void CLEAR_CONTRACT_FORM()
        {
            this.txtLessor.Text = string.Empty;
            this.txtLessorTIN.Text = string.Empty;
            this.txtLessee.Text = string.Empty;
            this.txtFromContract.Text = string.Empty;
            this.txtToContract.Text = string.Empty;
            this.txtContractRemarks.Text = string.Empty;
            this.hiddenSelectedLessor.Value = string.Empty;
            this.hiddenSelectedContract.Value = string.Empty;

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
        private bool VALIDATE_BRANCH_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
            {
                is_valid = false;
                this.txtBranchCode.CssClass += " is_invalid";
            }
            else
                this.txtBranchCode.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtBranchName.Text))
            {
                is_valid = false;
                this.txtBranchName.CssClass += " is-invalid";
            }
            else
                this.txtBranchName.CssClass = "form-control";

            return is_valid;
        }


        private bool VALIDATE_CONTRACT_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.hiddenSelectedLessor.Value))
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

            if (string.IsNullOrWhiteSpace(this.txtLessee.Text))
            {
                this.txtLessee.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtLessee.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtFromContract.Text))
            {
                this.txtFromContract.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtFromContract.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtToContract.Text))
            {
                this.txtToContract.CssClass += " is-invalid";
                is_valid = false;
            }
            else
                this.txtToContract.CssClass = "form-control";

            return is_valid;
        }

        private void UPSERT_RENTAL_CONTRACT()
        {
            //Get the data for Insert
            int lessor = int.Parse(this.hiddenSelectedLessor.Value);
            string lessee = this.txtLessee.Text;
            DateTime from_date = DateTime.Parse(this.txtFromContract.Text);
            DateTime to_date = DateTime.Parse(this.txtToContract.Text);
            string branch_code = this.txtBranchCode.Text;
            string remarks = this.txtContractRemarks.Text;

            if (string.IsNullOrWhiteSpace(this.hiddenSelectedContract.Value))
            {
                //Insert the new Rental Contract
                this.oBK.INSERT_BRANCH_RENTAL_CONTRACT(lessor, lessee, from_date, to_date, branch_code, remarks);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHDATA.ToString(), "INSERT", Session["Username"].ToString());

                //Show a Success Toast
                this.Show_Message_Toast("Successfully added a new Contract for " + this.txtBranchName.Text + " branch with " + this.txtLessor.Text);
            }
            else
            {
                int contract_id = int.Parse(this.hiddenSelectedContract.Value);
                
                //Update the Rental Contract
                this.oBK.UPDATE_BRANCH_RENTAL_CONTRACT(contract_id,lessor,lessee,from_date,to_date,branch_code,remarks);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHDATA.ToString(), "UPDATE", Session["Username"].ToString());

                //Show a Success Toast
                this.Show_Message_Toast("Successfully updated Contract for " + this.txtBranchName.Text + " branch with " + this.txtLessor.Text);
            }

            this.CLEAR_CONTRACT_FORM();
            this.DISPLAY_BRANCH_RENTAL_CONTRACTS();
            this.pContractForm.Visible = false;
            this.pContractList.Visible = true;
            this.upRental.Update();
        }

        private void UPSERT_BRANCH()
        {
            //Get the data
            string branch_code = this.txtBranchCode.Text;
            string branch_name = this.txtBranchName.Text;
            string branch_address = this.txtBranch_Address.Text;
            string branch_TIN = this.txtBranchTIN.Text;
            string company_code = this.ddCompanyLists.SelectedValue;
            int supervisor_id = 0;
            bool is_active = this.cbOpen.Checked;

            //Update the selected Branch
            this.oMaster.UPSERT_BRANCH(branch_code, branch_name, branch_TIN, branch_address, company_code, supervisor_id, is_active);

            //Insert an Audit Log
            this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHDATA.ToString(), "UPDATE", Session["Username"].ToString());

            //Show Success Toast
            this.Show_Message_Toast("Successfully Recorded " + branch_name);

            this.DISPLAY_BRANCH_LISTS();
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
            //int _branchID = Convert.ToInt32(this.gvBranchList.DataKeys[r.RowIndex].Values[0].ToString());
            //ViewState["V_SUPPLIERID"] = _supplierID;

            string branch_code = this.gvBranchList.DataKeys[r.RowIndex].Values[1].ToString();
            this.txtBranchCode.Text = branch_code;
            //ViewState["V_BRANCHCODE"] = _branchCode ;

            this.pBranchLists.Visible = false;
            this.pBranchInputForm.Visible = true;

            this.DISPLAY_BRANCH_DETAILS();
            this.DISPLAY_BRANCH_SALES();
            this.DISPLAY_BRANCH_EXPENSES();
            this.DISPLAY_BRANCH_RENTAL_CONTRACTS();

            //DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            //dv.RowFilter = "BranchID='" + _branchID + "'";


            //if (dv.Count > 0)
            //{
              
            //    //Show the entry field
            //    panelBranchLists.Visible = false;
            //    pBranchInputForm.Visible = true;

            //    this.DISPLAY_BRANCH_EXPENSES(this.txtBranchCode.Text);
            //    this.DISPLAY_BRANCH_RENTAL_CONTRACTS();

            //    foreach (DataRowView dvr in dv)
            //    {
            //        //Display Details
            //        txtBranchName.Text = dvr["Branch_Name"].ToString().Trim();
            //        //ddSupervisorLists.SelectedValue = dvr["SupervisorID"].ToString();
            //        ddCompanyLists.SelectedValue = dvr["CompanyCode"].ToString();
            //        this.txtBranchTIN.Text = dvr["BranchTIN"].ToString();
            //        //txtSupplierTIN.Text = dvr["S_TIN"].ToString();
            //        //cbVAT.Checked = (bool)dvr["IsVat"];

            //    }

            //    //ViewState["V_ACTION"] = 1; //This will hold the option for action.

            //    //Calling display function for default utilities
            //    //DISPLAY_BRANCH_DEFAULT_UTILITIES(_branchCode);

            //    this.DISPLAY_BRANCH_SALES();
            //}
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            this.pBranchLists.Visible = true;
            this.pBranchInputForm.Visible = false;
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            this.pBranchLists.Visible = false;
            this.pBranchInputForm.Visible = true;

            this.CLEAR_BASIC();

            this.txtBranchName.Focus();
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
        //    if (!string.IsNullOrWhiteSpace(txtProvider.Text))
        //    {
        //        oBK.INSERT_DEFAULT_BRANCH_UTILITIES(ViewState["V_BRANCHCODE"].ToString(), txtProvider.Text.Trim(), txtProviderAcctNumber.Text, txtTIN.Text, txtRemarks.Text);

        //        DISPLAY_BRANCH_DEFAULT_UTILITIES(ViewState["V_BRANCHCODE"].ToString());

               

        //        //Success toast message
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('New Provider Added.');</script>", false);

        //        //call event of back button
        //        lnkProviderBack_Click(sender, e);
        //    }
        //}

        //protected void lnkUtilitySelect_Click(object sender, EventArgs e)
        //{
        //    var selEdit = (Control)sender;
        //    GridViewRow r = (GridViewRow)selEdit.NamingContainer;
        //    int _supplierID = Convert.ToInt32(r.Cells[0].Text);

        //    DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
        //    dv.RowFilter = "SupplierID='" + _supplierID + "'";

        //    if (dv.Count > 0)
        //    {
        //        foreach (DataRowView dvr in dv)
        //        {
        //            //txtProvider.Text = dvr["Supplier_Name"].ToString();
        //            //txtTIN.Text = dvr["TIN"].ToString();

        //        }
                
        //    }
        //}

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
            if (!string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
                this.DISPLAY_BRANCH_SALES();
        }

        protected void ddSalesYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
                this.DISPLAY_BRANCH_SALES();
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
            if(!string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
                this.DISPLAY_BRANCH_EXPENSES();
        }

        protected void ddExpenseYearFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.txtBranchCode.Text))
                this.DISPLAY_BRANCH_EXPENSES();
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
            int supplier_id = int.Parse(this.gvSupplierList.DataKeys[r.RowIndex].Value.ToString());

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + supplier_id + "'";

            DataRowView row = dv[0];

            this.hiddenSelectedLessor.Value = supplier_id.ToString();
            this.txtLessor.Text = row["Supplier_Name"].ToString();
            this.txtLessorTIN.Text = row["TIN"].ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "<script>closeSupplierModal();</script>", false);
            upRental.Update();
        }

        protected void btnSaveNewContract_Click(object sender, EventArgs e)
        {
            if (VALIDATE_CONTRACT_FORM())
                this.UPSERT_RENTAL_CONTRACT();
            else
                this.Show_Error_Toast("Error - Invalid Input. Please check the highlighted fields.");
            
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_BRANCH_FORM())
            {
                this.UPSERT_BRANCH();
            }
            else
                this.Show_Error_Toast("Error - Invalid input. Please check the highlighted fields.");
        }

        protected void btnExpenseEdit_Click(object sender, EventArgs e)
        {
            Session["EditExpense"] = this.hiddenSelectedExpense.Value;
            Response.Redirect("BranchExpenses.aspx");
        }

        protected void btnEditContract_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int contract_id = int.Parse(this.gvRentalContract.DataKeys[r.RowIndex].Value.ToString());
            this.hiddenSelectedContract.Value = contract_id.ToString();

            this.DISPLAY_BRANCH_RENTAL_CONTRACT_DETAILS();
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