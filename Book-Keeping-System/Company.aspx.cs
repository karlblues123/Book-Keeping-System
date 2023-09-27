using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Company : System.Web.UI.Page
    {
        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_COMPANY_LISTS();
            }
        }

        #region EVENTS

        protected void lnkView_Click(object sender, EventArgs e)
        {
            pList.Visible = false;
            pDetails.Visible = true;
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            pDetails.Visible = false;
            pList.Visible = true;
        }
        #endregion

        #region LOCAL FUNCTIONS
        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable dt = oMaster.GET_COMPANY_LISTS();

            gvCompanyList.DataSource = dt;
            gvCompanyList.DataBind();
        }

        private void DISPLAY_COMPANY_EXPENSES()
        {
            //TODO Display the Expenses of the Selected Company
        }
        #endregion

        
    }
}