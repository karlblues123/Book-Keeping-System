using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region LOCAL FUNCTIONS
        private bool VALIDATE_INPUT()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtCurrentPassword.Text))
            {
                is_valid = false;
                this.txtCurrentPassword.CssClass += " is-invalid";
            }
            else
                this.txtCurrentPassword.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtConfirmCurrent.Text))
            {
                is_valid = false;
                this.txtConfirmCurrent.CssClass += " is-invalid";
            }
            else
                this.txtConfirmCurrent.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtNewPassword.Text))
            {
                is_valid = false;
                this.txtNewPassword.CssClass += " is-invalid";
            }
            else
                this.txtNewPassword.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtConfirmNew.Text))
            {
                is_valid = false;
                this.txtConfirmNew.CssClass += " is-invalid";
            }
            else
                this.txtConfirmNew.CssClass = "form-control";

            if (!string.Equals(this.txtCurrentPassword.Text, this.txtConfirmCurrent.Text) || !string.Equals(this.txtNewPassword.Text, this.txtConfirmNew.Text))
            {
                is_valid = false;
                this.Show_Error_Toast("Error - Invalid Input. Please try again.");
            }

            return is_valid;
        }

        private void UPDATE_USER_PASSWORD()
        {
            string username = Session["Username"].ToString();
            string password = this.txtCurrentPassword.Text;
            string new_password = this.txtNewPassword.Text;

            //Check if the Login credentials match
            if (this.oSys.VALIDATE_USER(username, password) > -1)
            {
                this.oSys.UPDATE_USER_PASSWORD(username, new_password);

                this.Show_Message_Toast("Succesfully Updated your password.");
            }
            else
            {
                this.Show_Error_Toast("Error - Invalid Input");
            }
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
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_INPUT())
            {
                this.UPDATE_USER_PASSWORD();
            }
        }
        #endregion
    }
}