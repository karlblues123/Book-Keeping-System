using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class BKSUsers : System.Web.UI.Page
    {
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Redirect back to Home page if the User is not an Admin
                if (int.Parse(Session["AccessLevel"].ToString()) != 1)
                    Response.Redirect("Home.aspx");
                this.DISPLAY_USERS();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_USERS()
        {
            //Get the list of users TODO filter out Admin users
            DataTable data = this.oSys.GET_LIST_USERS();

            //Display the data to the control
            this.gvUsers.DataSource = data;
            this.gvUsers.DataBind();
        }

        private void UPDATE_USER(int index)
        {
            //Get the data
            string user = this.gvUsers.DataKeys[index].Value.ToString();
            bool is_active = (this.gvUsers.Rows[index].FindControl("cbActive") as CheckBox).Checked;
            //TODO Update user type

            //Update the selected User
            this.oSys.UPDATE_USER(user, is_active);
        }
        #endregion

        #region EVENTS
        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gvUsers.EditIndex = e.NewEditIndex;
            this.DISPLAY_USERS();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gvUsers.EditIndex = -1;
            this.DISPLAY_USERS();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            this.UPDATE_USER(e.RowIndex);

            this.gvUsers.EditIndex = -1;
            this.DISPLAY_USERS();
        }
        #endregion


    }
}