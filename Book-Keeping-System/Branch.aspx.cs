using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace Book_Keeping_System
{
    public partial class Branch : System.Web.UI.Page
    {
        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_BRANCH_LISTS();
            }
        }


        #region "Local UserDefined Function"

        private void DISPLAY_BRANCH_LISTS()
        {
            DataTable dt = oMaster.GET_BRANCH_LISTS();

            //Display sa gridview
            gvBranchList.DataSource = dt;
            gvBranchList.DataBind();
        }

       

        #endregion
    }
}