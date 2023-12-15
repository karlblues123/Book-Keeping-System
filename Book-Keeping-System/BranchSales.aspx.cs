using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;

namespace Book_Keeping_System
{
    
    public partial class BranchSales : System.Web.UI.Page
    {

        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DISPLAY_BRANCH_LISTS();

            }
        }

        #region EVENTS
        protected void lnkRecordSale_Click(object sender, EventArgs e)
        {
            DateTime dt;

            //Add is-invalid CSS Class to fields with empty or invalid inputs
            if (String.IsNullOrEmpty(txtSelectedBranch.Text))
                txtSelectedBranch.CssClass += " is-invalid";
            else
                txtSelectedBranch.CssClass = "form-control";

            if(!DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt))
                txtDate.CssClass += " is-invalid";
            else
                txtDate.CssClass = "form-control";

            if (DateTime.TryParseExact(txtDate.Text, "yyyy-MM-dd", new CultureInfo("en-US"), DateTimeStyles.None, out dt) && !String.IsNullOrEmpty(txtSelectedBranch.Text))
            {
               
                //TODO Insert Branch Sales in DB

                txtDate.Text = DateTime.Parse(txtDate.Text).AddDays(1).ToString("yyyy-MM-dd");

                Show_Message_Toast("Sales recorded.");
                CLEAR_INPUTS();

                ScriptManager.GetCurrent(this.Page).SetFocus(this.txtChickenQuantity);
            }
            else
            {
                Show_Error_Toast("Invalid input. Please check the highlighted fields.");
                
            }
                
        }

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
                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtSelectedBranch.Text = dvr["Branch_Name"].ToString().Trim();

                }

            }
        }
        #endregion

        #region LOCAL FUNCTIONS

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private void DISPLAY_BRANCH_LISTS()
        {
            DataTable dt = oMaster.GET_BRANCH_LISTS();

            //Display in GridView
            gvBranchList.DataSource = dt;
            gvBranchList.DataBind();
        }

        private void CLEAR_INPUTS()
        {
            txtChickenPrice.Text = "0";
            txtChickenQuantity.Text = "0";
            txtChickenTotal.Text = "0";

            txtAtsaraPrice.Text = "0";
            txtAtsaraQuantity.Text = "0";
            txtAtsaraTotal.Text = "0";
        }

        #endregion
    }
}