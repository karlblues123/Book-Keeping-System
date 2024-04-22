using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System.Scripts
{
    public partial class AuditLogs : System.Web.UI.Page
    {
        xSysC oSys = new xSysC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.Parse(Session["AccessLevel"].ToString()) != 1)
                    Response.Redirect("Home.aspx");
                this.DISPLAY_AUDIT_LOGS();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_AUDIT_LOGS()
        {
            DataTable data = this.oSys.GET_AUDIT_LOGS();

            this.gvLogs.DataSource = data;
            this.gvLogs.DataBind();
        }
        #endregion
    }
}