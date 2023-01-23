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
            dt.Columns.Add("Address",typeof(string));
            dt.Columns.Add("Type", typeof(int));

            dt.Rows.Add(CreateSupplierEntry("Maynilad","Manila",2,dt));
            dt.Rows.Add(CreateSupplierEntry("Meralco", "Manila", 1, dt));
            dt.Rows.Add(CreateSupplierEntry("S&R - Imus Branch", "Imus City", 3, dt));

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
    }
}