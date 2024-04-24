using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Supplier : System.Web.UI.Page
    {

        MasterC oMaster = new MasterC();
        BKC oBK = new BKC();
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_SUPPLIER_LISTS();
            }
        }

        #region LOCAL FUNCTIONS

        private void DISPLAY_SUPPLIER_LISTS()
        {
            DataTable data = this.oMaster.GET_SUPPLIER_LISTS();

            //Display the data in the control
            this.gvSupplierList.DataSource = data;
            this.gvSupplierList.DataBind();
        }

        private void CLEAR_INPUTS()
        {
            this.hiddenSelectedSupplier.Value = string.Empty;
            this.txtSupplierName.Text = string.Empty;
            this.txtSupplierAddress.Text = string.Empty;
            this.txtSupplierTIN.Text = string.Empty;
            this.cbVAT.Checked = false;
        }

        private void DISPLAY_SELECTED_SUPPLIER()
        {
            //Check if there is actually a selected Supplier
            if (!string.IsNullOrEmpty(this.hiddenSelectedSupplier.Value))
            {
                //Get the selected Supplier
                DataView data = this.oMaster.GET_SUPPLIER_LISTS().DefaultView;
                data.RowFilter = "SupplierID='" + this.hiddenSelectedSupplier.Value + "'";

                if (data.Count > 0)
                {
                    //Display Details
                    this.txtSupplierName.Text = data[0]["Supplier_Name"].ToString();
                    this.txtSupplierAddress.Text = data[0]["Supplier_Address"].ToString();
                    this.txtSupplierTIN.Text = data[0]["TIN"].ToString();
                    this.cbVAT.Checked = bool.Parse(data[0]["IsVat"].ToString());
                    this.txtContactNumber.Text = data[0]["Contact_Number"].ToString();
                    this.txtContactPerson.Text = data[0]["Contact_Person"].ToString();
                }
            }
            else
            {
                this.CLEAR_INPUTS();
            }
        }

        private bool VALIDATE_FORM()
        {
            bool is_valid = false;

            //Validation
            if (string.IsNullOrWhiteSpace(this.txtSupplierName.Text))
                this.txtSupplierName.CssClass += " is-invalid";
            else
                this.txtSupplierName.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtSupplierTIN.Text))
                this.txtSupplierTIN.CssClass += " is-invalid";
            else
                this.txtSupplierTIN.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtSupplierAddress.Text))
                this.txtSupplierAddress.CssClass += " is-invalid";
            else
                this.txtSupplierAddress.CssClass = "form-control";

            if (!string.IsNullOrWhiteSpace(this.txtSupplierName.Text) && !string.IsNullOrWhiteSpace(this.txtSupplierTIN.Text) 
                && !string.IsNullOrWhiteSpace(this.txtSupplierAddress.Text))
                is_valid = true;

            return is_valid;
        }

        private void INSERT_SUPPLIER()
        {
            //Validate the form
            if (VALIDATE_FORM())
            {
                string supplier_name = this.txtSupplierName.Text;
                string supplier_address = this.txtSupplierAddress.Text;
                string supplier_TIN = this.txtSupplierTIN.Text;
                bool is_vat = this.cbVAT.Checked;
                string supplier_contact = this.txtContactNumber.Text;
                string supplier_person = this.txtContactPerson.Text;

                //Insert the new Supplier
                this.oMaster.INSERT_SUPPLIER_DATA(supplier_name, supplier_address, supplier_TIN, is_vat, supplier_contact, supplier_person);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.SUPPLIERDATA.ToString(), "INSERT", Session["Username"].ToString());

                //Show Success toast
                this.Show_Message_Toast("Successfully added " + txtSupplierName.Text + " to the database");

                //Refresh the Supplier list
                this.DISPLAY_SUPPLIER_LISTS();
            }
            //Display Error toast
            else
                this.Show_Error_Toast("Error - Invalid input. Please resubmit with complete necessary information.");
        }

        private void UPDATE_SUPPLIER()
        {
            //Validate the form
            if (VALIDATE_FORM())
            {
                //Get the data for Update
                int id = int.Parse(this.hiddenSelectedSupplier.Value);
                string supplier_name = this.txtSupplierName.Text;
                string supplier_address = this.txtSupplierAddress.Text;
                string supplier_TIN = this.txtSupplierTIN.Text;
                bool is_vat = this.cbVAT.Checked;
                string supplier_contact = this.txtContactNumber.Text;
                string supplier_person = this.txtContactPerson.Text;

                //Update the selected Supplier
                this.oMaster.UPDATE_SUPPLIER_DATA(id,supplier_name,supplier_address,supplier_TIN,is_vat,supplier_contact,supplier_person);

                //Insert an Audit Log
                this.oSys.INSERT_AUDIT_LOG(xSysC.Modules.SUPPLIERDATA.ToString(), "UPDATE", Session["Username"].ToString());

                //Show Success toast
                this.Show_Message_Toast("Successfully updated " + txtSupplierName.Text);

                //Refresh the Supplier list
                this.DISPLAY_SUPPLIER_LISTS();
            }
            //Display Error toast
            else
                this.Show_Error_Toast("Error - Invalid input. Please check the highlighted fields.");
        }

        private void Show_Message_Toast(string msg)
        {
            //Success toast message
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            //Error toast message
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedSupplier.Value)) 
                this.UPDATE_SUPPLIER();
            else
                this.INSERT_SUPPLIER();
        }

        protected void hiddenSelectedSupplier_ValueChanged(object sender, EventArgs e)
        {
            this.DISPLAY_SELECTED_SUPPLIER();
        }
        #endregion


    }
}