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
                DISPLAY_COMPANY_LISTS();
                DISPLAY_SUPERVISOR_LISTS();
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


        private void DISPLAY_COMPANY_LISTS()
        {
            DataTable dt = oMaster.GET_COMPANY_LISTS();

            ddCompanyLists.DataSource = dt;
            ddCompanyLists.DataTextField = dt.Columns["Company_Name"].ToString();
            ddCompanyLists.DataValueField = dt.Columns["CompanyCode"].ToString();
            ddCompanyLists.DataBind();
        }

        private void DISPLAY_SUPERVISOR_LISTS()
        {
            DataTable dt = oMaster.GET_SUPERVISOR_LISTS();

            ddSupervisorLists.DataSource = dt;
            ddSupervisorLists.DataTextField = dt.Columns["Supervisor_Name"].ToString();
            ddSupervisorLists.DataValueField = dt.Columns["SupervisorID"].ToString();
            ddSupervisorLists.DataBind();

        }


        private void CLEAR_INPUTS()
        {
            txtBranchName.Text = "";
            txtBranch_Address.Text = "";
            ddSupervisorLists.SelectedIndex = 0;
            ddCompanyLists.SelectedIndex = 0;

            txtElectricityProvider.Text = "";
            txtElectricProviderAcctNumber.Text = "";
            txtWaterProvider.Text = "";
            txtWaterProviderAcctNumber.Text = "";

        }

        #endregion

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
           

            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _branchID = Convert.ToInt32(r.Cells[0].Text);
            //ViewState["V_SUPPLIERID"] = _supplierID;



            DataView dv = oMaster.GET_BRANCH_LISTS().DefaultView;
            dv.RowFilter = "BranchID='" + _branchID + "'";


            if (dv.Count > 0)
            {
              
                //Show the entry field
                panelBranchLists.Visible = false;
                panelBranchInputForm.Visible = true;

                panelSideInputs.Enabled = true;

                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtBranchName.Text = dvr["Branch_Name"].ToString().Trim();
                    ddSupervisorLists.SelectedValue = dvr["SupervisorID"].ToString();
                    ddCompanyLists.SelectedValue = dvr["CompanyCode"].ToString();
                    //txtSupplierTIN.Text = dvr["S_TIN"].ToString();
                    //cbVAT.Checked = (bool)dvr["IsVat"];

                }

                //ViewState["V_ACTION"] = 1; //This will hold the option for action.

            }
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            panelBranchLists.Visible = true;
            panelBranchInputForm.Visible = false;
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            panelBranchLists.Visible = false;
            panelBranchInputForm.Visible = true;
            panelSideInputs.Enabled = false;

            CLEAR_INPUTS();

            txtBranchName.Focus();
        }
    }
}