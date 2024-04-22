using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class SignUp : System.Web.UI.Page
    {
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        #region LOCAL FUNCTIONS
        private bool VALIDATE_INPUT()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtUsername.Text))
            {
                is_valid = false;
                this.txtUsername.CssClass += " is-invalid";
            }
                
            if (string.IsNullOrWhiteSpace(this.txtPassword.Text))
            {
                is_valid = false;
                this.txtPassword.CssClass += " is-invalid";
            }

            if (string.IsNullOrWhiteSpace(this.txtConfirmPassword.Text))
            {
                is_valid = false;
                this.txtConfirmPassword.CssClass += " is-invalid";
            }

            if (!is_valid)
                this.Show_Error_Toast("Error - Invalid input. Please check the highlighted fields");
            else
            {
                this.txtConfirmPassword.CssClass = "form-control";
                this.txtPassword.CssClass = "form-control";
                this.txtUsername.CssClass = "form-control";
            }

            return is_valid;
        }

        private void INSERT_NEW_USER()
        {
            string username = this.txtUsername.Text;
            string password = this.txtPassword.Text;
            string confirm_password = this.txtConfirmPassword.Text;

            DataTable data = this.oSys.GET_USER(username);

            if (data.Rows.Count == 0)
            {
                if (string.Equals(password, confirm_password))
                {
                    this.oSys.INSERT_NEW_USER(username, password);

                    this.Show_Message_Toast("Successfully Registered! Please contact the administration or IT personnel to activate your account.");
                }
                else
                    this.Show_Error_Toast("Error - Invalid input.");
            }
            else
                this.Show_Error_Toast("Error - Invalid input.");
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
        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (VALIDATE_INPUT())
                this.INSERT_NEW_USER();
        }
        #endregion
    }
}