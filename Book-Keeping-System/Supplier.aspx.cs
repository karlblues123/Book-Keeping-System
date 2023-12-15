﻿using System;
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
        BKC oBK = new BKC();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  CreateSupplierList();

                DISPLAY_SUPPLIER_LISTS();
                //DISPLAY_EXPENSES_LISTS();

            }
        }

        private DataRow CreateSupplierEntry(string name,string address, int type, DataTable dt)
        {
            DataRow dr = dt.NewRow();

            dr[0] = name;
            dr[1] = address;
            dr[2] = type;

            return dr;
        }

        #region EVENTS
        protected void lnkSave_Click(object sender, EventArgs e)
        {

            //Validation
            if (String.IsNullOrEmpty(txtSupplierName.Text))
                txtSupplierName.CssClass += " is-invalid";
            else
                txtSupplierName.CssClass = "form-control";

            if (String.IsNullOrEmpty(txtSupplierTIN.Text))
                txtSupplierTIN.CssClass += " is-invalid";
            else
                txtSupplierTIN.CssClass = "form-control";

            if (String.IsNullOrEmpty(txtSupplierAddress.Text))
                txtSupplierAddress.CssClass += " is-invalid";
            else
                txtSupplierAddress.CssClass = "form-control";

            if(!String.IsNullOrEmpty(txtSupplierName.Text) && !String.IsNullOrEmpty(txtSupplierTIN.Text) && !String.IsNullOrEmpty(txtSupplierAddress.Text))
            {
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
            //TODO add in error toast
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('Invalid input. Please check the highlighted fields.');</script>", false);
            }


            
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
                    lblModalSupplier.Text = txtSupplierName.Text;
                }

                ViewState["V_ACTION"] = 1; //This will hold the option for action.
                upMain.Update();
            }
            else
            {
                txtSupplierTIN.Text = "Error";

            }
         }

        protected void lnkConfirmDelete_Click(object sender, EventArgs e)
        {
            //TODO Delete supplier in database

            pList.Visible = true;
            pForm.Visible = false;
        }

        protected void gvSupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach(GridViewRow row in gvSupplierList.Rows)
            {
                LinkButton edit = row.FindControl("lnkEdit") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
            }
        }
        #endregion

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


        private void DISPLAY_EXPENSES_LISTS()
        {
            DataTable dt = oBK.GET_EXPENSES_LISTS();

            ddSupplierType.DataSource = dt;
            ddSupplierType.DataTextField = dt.Columns["Expenses_Desc"].ToString();
            ddSupplierType.DataValueField = dt.Columns["ExpensesID"].ToString();
            ddSupplierType.DataBind();
        }


        #endregion

        
    }
}