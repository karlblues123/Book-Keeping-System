using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;

namespace Book_Keeping_System
{
    
    public partial class BranchSales : System.Web.UI.Page
    {

        MasterC oMaster = new MasterC();
        BKC oBK = new BKC();
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_BRANCH_LISTS();
            }
        }

        

        #region LOCAL FUNCTIONS

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private void DISPLAY_BRANCH_LISTS()
        {
            DataView data = oMaster.GET_BRANCH_LISTS().DefaultView;
            data.RowFilter = "IsActive = 1";

            //Display in GridView
            gvBranchList.DataSource = data;
            gvBranchList.DataBind();
        }

        private void DISPLAY_DAY_SALE()
        {
            //Get the Sale of the Branch on the specified date
            DataTable data = this.oBK.GET_BRANCH_DAY_SALE(this.hiddenSelectedBranch.Value, Convert.ToDateTime(txtDate.Text));

            //Display the data to the fields
            if (data.Rows.Count > 0)
            {
                this.txtInvoiceStart.Text = data.Rows[0]["StartingInvoice"].ToString();
                this.txtInvoiceEnd.Text = data.Rows[0]["EndingInvoice"].ToString();
                this.txtChickenQuantity.Text = data.Rows[0]["ChickenQuantity"].ToString();
                this.txtChickenPrice.Text = data.Rows[0]["ChickenPrice"].ToString();
                this.txtChickenTotal.Text = data.Rows[0]["ChickenTotal"].ToString();
                this.txtAtsaraQuantity.Text = data.Rows[0]["AtsaraQuantity"].ToString();
                this.txtAtsaraPrice.Text = data.Rows[0]["AtsaraPrice"].ToString();
                this.txtAtsaraTotal.Text = data.Rows[0]["AtsaraTotal"].ToString();
            }
            else
                CLEAR_INPUTS();
        }

        private void CLEAR_INPUTS()
        {
            this.txtInvoiceStart.Text = string.Empty;
            this.txtInvoiceEnd.Text = string.Empty;

            txtChickenPrice.Text = "0";
            txtChickenQuantity.Text = "0";
            txtChickenTotal.Text = "0";

            txtAtsaraPrice.Text = "0";
            txtAtsaraQuantity.Text = "0";
            txtAtsaraTotal.Text = "0";
        }

        private bool VALIDATE_FORM()
        {
            bool isValidated = false;

            DateTime dt;

            //Add is-invalid CSS Class to fields with empty or invalid inputs
            if (string.IsNullOrWhiteSpace(txtSelectedBranch.Text))
                txtSelectedBranch.CssClass += " is-invalid";
            else
                txtSelectedBranch.CssClass = "form-control";

            if (!DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
                txtDate.CssClass += " is-invalid";
            else
                txtDate.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(txtInvoiceStart.Text))
                txtInvoiceStart.CssClass += " is-invalid";
            else
                txtInvoiceStart.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(txtInvoiceEnd.Text))
                txtInvoiceEnd.CssClass += " is-invalid";
            else
                txtInvoiceEnd.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(txtChickenTotal.Text))
                txtChickenTotal.CssClass += " is-invalid";
            else
                txtChickenTotal.CssClass = "form-control";

            if (!string.IsNullOrWhiteSpace(txtSelectedBranch.Text) && DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt)
                && !string.IsNullOrWhiteSpace(txtChickenTotal.Text) && !string.IsNullOrWhiteSpace(txtInvoiceStart.Text) && !string.IsNullOrWhiteSpace(txtInvoiceEnd.Text))
                isValidated = true;

            return isValidated;
        }

        private void UPSERT_SALES()
        {
            if (VALIDATE_FORM())
            {
                //Get the sales data
                int chicken_quantity;
                int.TryParse(this.txtChickenQuantity.Text, out chicken_quantity);
                decimal chicken_price;
                decimal.TryParse(this.txtChickenPrice.Text, out chicken_price);
                decimal chicken_total;
                decimal.TryParse(this.txtChickenTotal.Text, out chicken_total);
                int atsara_quantity;
                int.TryParse(this.txtAtsaraQuantity.Text, out atsara_quantity);
                decimal atsara_price;
                decimal.TryParse(this.txtAtsaraPrice.Text, out atsara_price);
                decimal atsara_total;
                decimal.TryParse(this.txtAtsaraTotal.Text, out atsara_total);
                DateTime date = Convert.ToDateTime(txtDate.Text);

                //Get the Sale of the Branch on the specified date
                DataTable data = this.oBK.GET_BRANCH_DAY_SALE(this.hiddenSelectedBranch.Value, Convert.ToDateTime(txtDate.Text));

                if(data.Rows.Count > 0)
                {
                    //Update the Sales
                    this.oBK.UPDATE_BRANCH_SALES(this.hiddenSelectedBranch.Value, date, this.txtInvoiceStart.Text,
                    this.txtInvoiceEnd.Text, chicken_quantity, chicken_price, chicken_total, atsara_quantity, atsara_price,
                    atsara_total);

                    //Insert logs
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHSALES.ToString(), "UPDATE", Session["Username"].ToString());

                    Show_Message_Toast("Successfully updated " + date.ToString("yyyy-MM-dd") + " sales for " + this.txtSelectedBranch.Text);
                }
                else
                {
                    //Insert Sales into database
                    this.oBK.INSERT_BRANCH_SALES(this.hiddenSelectedBranch.Value, date, this.txtInvoiceStart.Text,
                        this.txtInvoiceEnd.Text, chicken_quantity, chicken_price, chicken_total, atsara_quantity, atsara_price,
                        atsara_total);

                    //Insert logs
                    this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.BRANCHSALES.ToString(), "INSERT", Session["Username"].ToString());

                    //Show success toast
                    Show_Message_Toast("Successfully recorded " + date.ToString("yyyy-MM-dd") + " sales for " + this.txtSelectedBranch.Text);
                }
                
                //Move to next day
                txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");
                txtChickenQuantity.Text = "0";
                txtChickenTotal.Text = "0";
                txtAtsaraQuantity.Text = "0";
                txtAtsaraTotal.Text = "0";
                ScriptManager.GetCurrent(this.Page).SetFocus(this.txtInvoiceStart);
            }
            else
            {
                Show_Error_Toast("Error - Invalid input. Please check the highlighted fields.");
            }


        }

        #endregion

        #region EVENTS
        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            this.hiddenSelectedBranch.Value = this.gvBranchList.DataKeys[r.RowIndex].Value.ToString();

            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchCode='" + this.hiddenSelectedBranch.Value + "'";


            if (dv.Count > 0)
            {
                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtSelectedBranch.Text = dvr["Branch_Name"].ToString().Trim();

                }

            }
        }

        protected void lnkSaveSales_Click(object sender, EventArgs e)
        {
            UPSERT_SALES();
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.hiddenSelectedBranch.Value))
            {
                this.DISPLAY_DAY_SALE();
            }
        }
        #endregion


    }
}