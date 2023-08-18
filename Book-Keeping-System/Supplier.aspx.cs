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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CreateSupplierList();
                
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
            //TODO Save data onclick
        }

        protected void lnkNewSupplier_Click(object sender, EventArgs e)
        {
            pForm.Visible = true;
            pList.Visible = false;
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            pList.Visible = true;
            pForm.Visible = false;
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            pForm.Visible = true;
            pList.Visible = false;
            upMain.Update();
        }

        protected void gvSupplierList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach(GridViewRow row in gvSupplierList.Rows)
            {
                LinkButton edit = row.FindControl("lnkEdit") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(edit);
            }
        }
    }
}