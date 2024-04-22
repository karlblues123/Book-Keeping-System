using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Login : System.Web.UI.Page
    {
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }
        }

        #region LOCAL FUNCTIONS
        private int VALIDATE_USER()
        {
            int access_level = -1;

            if (string.IsNullOrWhiteSpace(this.txtUsername.Text))
                this.txtUsername.CssClass += " is-invalid";
            else
                this.txtUsername.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtPassword.Text))
                this.txtPassword.CssClass += " is-invalid";
            else
                this.txtPassword.CssClass = "form-control";

            if(!string.IsNullOrWhiteSpace(this.txtUsername.Text) && !string.IsNullOrWhiteSpace(this.txtPassword.Text))
            {
                string username = this.txtUsername.Text;
                string password = this.txtPassword.Text;

                access_level = this.oSys.VALIDATE_USER(username, password);
            }

            return access_level;
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }
        #endregion

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_USER() > -1)
            {
                Session["Username"] = this.txtUsername.Text;
                Session["AccessLevel"] = this.VALIDATE_USER();
                Response.Redirect("Home.aspx");

            }
            else
                this.Show_Error_Toast("Error - Invalid Input. Please check your input and try again.");
        }
    }
}