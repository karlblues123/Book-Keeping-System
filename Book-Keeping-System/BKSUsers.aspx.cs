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
                if (int.Parse(Session["AccessLevel"].ToString()) != 1)
                    Response.Redirect("Home.aspx");
                this.DISPLAY_USERS();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_USERS()
        {
            DataTable data = this.oSys.GET_LIST_USERS();

            this.gvUsers.DataSource = data;
            this.gvUsers.DataBind();
        }

        private void UPDATE_USER(int index)
        {
            //TODO Update selected User
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