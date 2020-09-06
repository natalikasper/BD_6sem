using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace _2lab
{
    class DB
    {
        SqlConnection conn;
        public void openConnection(string connStr)
        {
            conn = new SqlConnection(connStr);
            conn.Open();
        }

        public void closeConnection()
        {
            conn.Close();
        }

        public void add_author(string name, DateTime birthday, string phone)
        {
            using (SqlCommand cmd = new SqlCommand("add_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@birthday", birthday);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.ExecuteNonQuery();
            }
        }
        public void drop_author(string surname)
        {
            using (SqlCommand cmd = new SqlCommand("drop_author", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@surname", surname);
                cmd.ExecuteNonQuery();
            }
        }
        public void change_author(string surname, DateTime birthday, string phone)
        {
            using (SqlCommand cmd = new SqlCommand("change_author", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@surname", surname);
                cmd.Parameters.AddWithValue("@birthday", birthday);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.ExecuteNonQuery();
            }
        }


        public void add_client(string name, string adress)
        {
            using (SqlCommand cmd = new SqlCommand("add_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@adress", adress);
                cmd.ExecuteNonQuery();
            }
        }
        public void drop_client(string name)
        {
            using (SqlCommand cmd = new SqlCommand("drop_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                cmd.ExecuteNonQuery();
            }

        }
        public void change_client(string name, string adress)
        {
            using (SqlCommand cmd = new SqlCommand("change_client", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@adress", adress);
                cmd.ExecuteNonQuery();
            }
        }


        public void add_type(int id, string type)
        {
            using (SqlCommand cmd = new SqlCommand("add_type", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_type", id);
                cmd.Parameters.AddWithValue("@type", type);
                cmd.ExecuteNonQuery();
            }
        }
        public void drop_type(string type)
        {
            using (SqlCommand cmd = new SqlCommand("drop_type", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@type", type);
                cmd.ExecuteNonQuery();
            }

        }
        public void change_type(int id, string type)
        {
            using (SqlCommand cmd = new SqlCommand("change_type", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_type", id);
                cmd.Parameters.AddWithValue("@type", type);
                cmd.ExecuteNonQuery();
            }
        }


        public void add_prod (string type_prod, string title_prod, string author_prod)
        {
            using (SqlCommand cmd = new SqlCommand("add_prod", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("type_prod", type_prod);
                cmd.Parameters.AddWithValue("title_prod", title_prod);
                cmd.Parameters.AddWithValue("author_prod", author_prod);
                cmd.ExecuteNonQuery();
            }
        }
        public void change_prod(string type_prod, string title_prod, string author_prod)
        {
            using (SqlCommand cmd = new SqlCommand("change_prod", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("type_prod", type_prod);
                cmd.Parameters.AddWithValue("title_prod", title_prod);
                cmd.Parameters.AddWithValue("author_prod", author_prod);
                cmd.ExecuteNonQuery();
            }
        }
        public void drop_prod(string type_prod)
        {
            using (SqlCommand cmd = new SqlCommand("drop_prod", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@type_prod", type_prod);
                cmd.ExecuteNonQuery();
            }

        }


        public void add_order (DateTime date_start, DateTime date_end, int  client_order, int production_order, int cost_order)
        {
            using (SqlCommand cmd = new SqlCommand("add_order", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("date_start", date_start);
                cmd.Parameters.AddWithValue("date_end", date_end);
                cmd.Parameters.AddWithValue("client_order", client_order);
                cmd.Parameters.AddWithValue("production_order", production_order);
                cmd.Parameters.AddWithValue("cost_order", cost_order);
                cmd.ExecuteNonQuery();
            }
        }
        public void change_order(DateTime date_start, DateTime date_end, int client_order, int production_order, int cost_order)
        {
            using (SqlCommand cmd = new SqlCommand("change_order", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("date_start", date_start);
                cmd.Parameters.AddWithValue("date_end", date_end);
                cmd.Parameters.AddWithValue("client_order", client_order);
                cmd.Parameters.AddWithValue("production_order", production_order);
                cmd.Parameters.AddWithValue("cost_order", cost_order);
                cmd.ExecuteNonQuery();
            }
        }
        public void drop_order(DateTime date_start, DateTime date_end)
        {
            using (SqlCommand cmd = new SqlCommand("drop_order", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("date_start", date_start);
                cmd.Parameters.AddWithValue("date_end", date_end);
                cmd.ExecuteNonQuery();
            }
        }


    }
}
