using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace Book_Keeping_System
{
    public class baseC
    {
        public static string CS = ConfigurationManager.ConnectionStrings["SRPS_DB"].ToString();



        public static DataSet queryCommandDS(string sqlQuery)
        {
            DataSet ds = new DataSet();
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                }
            }

            return ds;
        }

        public static DataSet queryCommandDS_StoredProc(string sqlQuery)
        {
            DataSet ds = new DataSet();
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                }
            }

            return ds;
        }
        public static DataTable queryCommandDT(string sqlQuery)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        public static DataTable queryCommandDT_StoredProc(string sqlQuery)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }


        public DateTime GetServerDate()
        {
            DateTime svrDT;

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("SELECT GetDate()", cn))
                {


                    cn.Open();
                    svrDT = (DateTime)cmd.ExecuteScalar();
                }
            }

            return svrDT;

        }
    }
}