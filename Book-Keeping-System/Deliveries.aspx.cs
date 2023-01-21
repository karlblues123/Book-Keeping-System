using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class Deliveries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CreateMonthList();
            }
            
        }

        private void CreateMonthList()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("MonthTextField",typeof(string)));
            dt.Columns.Add(new DataColumn("MonthValueField", typeof(int)));

            dt.Rows.Add(CreateMonthRow("January", 1, dt));
            dt.Rows.Add(CreateMonthRow("February", 2, dt));
            dt.Rows.Add(CreateMonthRow("March", 3, dt));
            dt.Rows.Add(CreateMonthRow("April", 4, dt));
            dt.Rows.Add(CreateMonthRow("May", 5, dt));
            dt.Rows.Add(CreateMonthRow("June", 6, dt));
            dt.Rows.Add(CreateMonthRow("July", 7, dt));
            dt.Rows.Add(CreateMonthRow("August", 8, dt));
            dt.Rows.Add(CreateMonthRow("September", 9, dt));
            dt.Rows.Add(CreateMonthRow("October", 10, dt));
            dt.Rows.Add(CreateMonthRow("November", 11, dt));
            dt.Rows.Add(CreateMonthRow("December", 12, dt));

            DataView dv = new DataView(dt);
            ddMonthList.DataSource = dv;
            ddMonthList.DataBind();
        }

        private DataRow CreateMonthRow(string text,int value, DataTable dt)
        {
            DataRow dr = dt.NewRow();

            dr[0] = text;
            dr[1] = value;

            return dr;
        }

        private void CreateDayList()
        {
            DataTable dt = new DataTable();
            DataRow dr;

            dt.Columns.Add(new DataColumn("Day", typeof(DateTime)));
            dt.Columns.Add(new DataColumn("DailyTotal", typeof(float)));

            for (int i = 0; i < DateTime.DaysInMonth(DateTime.Now.Year,Int32.Parse(ddMonthList.SelectedValue)); i++)
            {
                dr = dt.NewRow();
                dr[0] = new DateTime(DateTime.Now.Year,Int32.Parse(ddMonthList.SelectedValue),i+1);
                dr[1] = 0.00f;
                dt.Rows.Add(dr);
            }

            DataView dv = new DataView(dt);

            gvBranchList.DataSource = dv;
            gvBranchList.DataBind();
        }


        //Events
        protected void txtSelect_Click(object sender, EventArgs e)
        {
            CreateDayList();
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            //TODO Fill up the form with the values
        }
    }

    
}