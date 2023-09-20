using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Supplier : System.Web.UI.Page
    {

        MasterC oMaster = new MasterC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  CreateSupplierList();

                DISPLAY_SUPPLIER_LISTS();
                
            }
        }

        private void CreateSupplierList()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("SupplierName", typeof(string));
            dt.Columns.Add("TIN",typeof(string));
            dt.Columns.Add("Type", typeof(int));

            dt.Rows.Add(CreateSupplierEntry("Maynilad", "005-393-442-00012", 2,dt));
            dt.Rows.Add(CreateSupplierEntry("Meralco", "000-101-528-00042", 1, dt));
            dt.Rows.Add(CreateSupplierEntry("S&R - Imus Branch", "246-969-491-011", 3, dt));

            gvSupplierList.DataSource = dt;
            gvSupplierList.DataBind();
        }

        private DataRow CreateSupplierEntry(string name,string address, int type, DataTable dt)
        {
            DataRow dr = dt.NewRow();

            dr[0] = name;
            dr[1] = address;
            dr[2] = type;

            return dr;
        }

        protected void lnkSave_Click(object sender, EventArgs e)
        {

            //Validation
            if ((int)ViewState["V_ACTION"] == 1) //It will proceed to Update
            {
                oMaster.UPDATE_SUPPLIER_DATA((int)ViewState["V_SUPPLIERID"], txtSupplierName.Text, txtSupplierAddress.Text, txtSupplierTIN.Text, cbVAT.Checked);

                //Success toast message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('Supplier Data updated!');</script>", false);
            }
            else //Will proceed to Insert Action
            {
                //This will Insert new Record of Supplier in database
                oMaster.INSERT_SUPPLIER_DATA(txtSupplierName.Text, txtSupplierAddress.Text, txtSupplierTIN.Text, cbVAT.Checked);
                //Success toast message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('New Supplier Added.');</script>", false);

            }


            DISPLAY_SUPPLIER_LISTS();


            //Return to default
            pList.Visible = true;
            pForm.Visible = false;
        }

        protected void lnkNewSupplier_Click(object sender, EventArgs e)
        {
            pForm.Visible = true;
            pList.Visible = false;

            CLEAR_INPUTS();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            pList.Visible = true;
            pForm.Visible = false;
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            //pForm.Visible = true;
            //pList.Visible = false;
            //upMain.Update();

            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            int _supplierID = Convert.ToInt32(r.Cells[0].Text);
            ViewState["V_SUPPLIERID"] = _supplierID;

         

            DataView dv = oMaster.GET_SUPPLIER_LISTS().DefaultView;
            dv.RowFilter = "SupplierID='" + _supplierID  + "'";


            if (dv.Count > 0)
            {
                CLEAR_INPUTS();
                //Show the entry field
                pForm.Visible = true;
                pList.Visible = false;

                foreach (DataRowView dvr in dv)
                {
                    //Display Details
                    txtSupplierName.Text = dvr["Supplier_Name"].ToString();
                    txtSupplierAddress.Text = dvr["Supplier_Address"].ToString();
                    txtSupplierTIN.Text = dvr["TIN"].ToString();
                    cbVAT.Checked = (bool)dvr["IsVat"];
                    
                }

                ViewState["V_ACTION"] = 1; //This will hold the option for action.

            }
            else
            {
                txtSupplierTIN.Text = "Error";

            }
         }

        protected void gvSupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach(GridViewRow row in gvSupplierList.Rows)
            {
                LinkButton edit = row.FindControl("lnkEdit") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
            }
        }

        #region "Local UserDefined Function"

        private void DISPLAY_SUPPLIER_LISTS()
        {
            DataTable dt = oMaster.GET_SUPPLIER_LISTS();

            //Display sa gridview
            gvSupplierList.DataSource = dt;
            gvSupplierList.DataBind();
        }

        private void CLEAR_INPUTS()
        {
            txtSupplierName.Text = "";
            txtSupplierAddress.Text = "";
            txtSupplierTIN.Text = "";
            cbVAT.Checked = false;

            ViewState["V_ACTION"] = 0;
        }

        #endregion

     
    }
}