﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Book_Keeping_System
{
    public partial class VATReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CreateMonthList();
                CreateTypeList();
            }
        }

        private void CreateMonthList()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("MonthTextField", typeof(string)));
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

        private DataRow CreateMonthRow(string text, int value, DataTable dt)
        {
            DataRow dr = dt.NewRow();

            dr[0] = text;
            dr[1] = value;

            return dr;
        }

        private void CreateTypeList()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("TypeTextField", typeof(string)));
            dt.Columns.Add(new DataColumn("TypeValueField", typeof(int)));

            dt.Rows.Add(CreateMonthRow("Electric", 1, dt));
            dt.Rows.Add(CreateMonthRow("Water", 2, dt));
            dt.Rows.Add(CreateMonthRow("Supply", 3, dt));

            DataView dv = new DataView(dt);
            ddReportTypeList.DataSource = dv;
            ddReportTypeList.DataBind();
        }

        //Event
        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            lnkNew.Visible = true;

            lblForm.Visible = true;
            lblForm.Text = ddMonthList.SelectedItem.Text + " " + ddReportTypeList.SelectedItem.Text + " Report"; 
        }
    }
}