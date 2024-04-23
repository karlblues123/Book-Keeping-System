using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Book_Keeping_System
{
    public class xSysC : baseC
    {
        internal enum Modules
        {
            BRANCHSALES,
            BRANCHEXPENSES,
            COMPANYEXPENSES,
            SUPPLIERDATA,
            BRANCHDATA,
            COMPANYDATA
        }
        
        #region LOCAL FUNCTIONS
        private string CREATE_MD5_HASH(string input)
        {
            using (MD5 hasher = MD5.Create())
            {
                byte[] hash = hasher.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder sBuilder = new StringBuilder();
                for (int i = 0; i < hash.Length; i++)
                {
                    sBuilder.Append(hash[i].ToString("x2"));
                }
                return sBuilder.ToString();
            }

        }

        internal int VALIDATE_USER(string username, string password)
        {
            int access_level = -1;

            DataRow user_info = this.GET_USER(username).Rows[0];

            string hash = this.CREATE_MD5_HASH(password);
            bool is_active = bool.Parse(user_info["IsActive"].ToString());

            if (is_active && string.Equals(hash, user_info["Password"].ToString()))
                access_level = int.Parse(user_info["UserType"].ToString());

            return access_level;
        }
        #endregion

        #region GET
        internal DataTable GET_USER(string username)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[xSys].[spGET_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_AUDIT_LOGS()
        {
            return queryCommandDT("SELECT * FROM [xSys].[AuditLogs_TF]");
        }

        internal DataTable GET_LIST_USERS()
        {
            return queryCommandDT_StoredProc("[xSys].[spGET_LIST_USERS]");
        }
        #endregion

        #region INSERT
        internal void INSERT_NEW_USER(string username, string password)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[xSys].[spINSERT_NEW_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@USERNAME", username);
                    cmd.Parameters.AddWithValue("@PASSWORD", this.CREATE_MD5_HASH(password));


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        internal void INSERT_AUDIT_LOG(string module, string actions, string username)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[xSys].[spINSERT_AUDIT_LOG_TRANS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@USERCODE", username);
                    cmd.Parameters.AddWithValue("@MODULE", module);
                    cmd.Parameters.AddWithValue("@ACTIONS", actions);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }
        #endregion

        #region UPDATE
        internal void UPDATE_USER_PASSWORD(string username, string password)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[xSys].[spUPDATE_USER_PASSWORD]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@USERNAME", username);
                    cmd.Parameters.AddWithValue("@PASSWORD", this.CREATE_MD5_HASH(password));


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        internal void UPDATE_USER(string username, bool is_active)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[xSys].[spUPDATE_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@USERNAME", username);
                    cmd.Parameters.AddWithValue("@ISACTIVE", is_active);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }
        #endregion
    }
}