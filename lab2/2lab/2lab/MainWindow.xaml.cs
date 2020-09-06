using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace _2lab
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        string connStr = @"Data Source=.\SQLEXPR;Initial Catalog=publishing_house;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        DataTable Authors = new DataTable();
        DataTable Clients = new DataTable();
        DataTable Orders = new DataTable();
        DataTable Types = new DataTable();
        DataTable Production = new DataTable();

        private void addAuthor_Click(object sender, RoutedEventArgs e)
        {
            string surname = textBoxSurname.Text;
            DateTime birthday = DateStart.SelectedDate.Value;
            string phone = textBoxPhone.Text;
            if (surname.Length == 0 || DateStart.SelectedDate.Value == null || phone.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_author(surname, birthday, phone);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void dropAuthor_Click(object sender, RoutedEventArgs e)
        {
            string surname = textBoxSurname.Text;

            if (surname.Length == 0)
            {
                MessageBox.Show("Проверьте данные паспорта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_author(surname);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void changeAuthor_Click(object sender, RoutedEventArgs e)
        {
            string surname = textBoxSurname.Text;
            DateTime birthday = DateStart.SelectedDate.Value;
            string phone = textBoxPhone.Text;
            if (surname.Length == 0 || DateStart.SelectedDate.Value == null || phone.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_author(surname, birthday, phone);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void allAuthor_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllAuthors";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Authors.Clear();
                    // Заполняем Dataset
                    command.Fill(Authors);
                    // Отображаем данные
                    usersGrid.ItemsSource = Authors.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void addClient_Click(object sender, RoutedEventArgs e)
        {
            string name = textBoxName.Text;
            string adress = textBoxAdress.Text;
            if (name.Length == 0 || adress.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_client(name, adress);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void dropClient_Click(object sender, RoutedEventArgs e)
        {
            string name = textBoxName.Text;

            if (name.Length == 0)
            {
                MessageBox.Show("Проверьте данные паспорта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_client(name);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void changeClient_Click(object sender, RoutedEventArgs e)
        {
            string name = textBoxName.Text;
            string adress = textBoxAdress.Text;
            if (name.Length == 0 || adress.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_client(name, adress);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void allClients_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllClients";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Clients.Clear();
                    // Заполняем Dataset
                    command.Fill(Clients);
                    // Отображаем данные
                    userGrid.ItemsSource = Clients.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }


        private void addType_Click(object sender, RoutedEventArgs e)
        {
            string type = textBoxType.Text;
            int id = Convert.ToInt32(textBoxId.Text);
            if (type.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_type(id, type);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void dropType_Click(object sender, RoutedEventArgs e)
        {
            string type = textBoxType.Text;

            if (type.Length == 0)
            {
                MessageBox.Show("Проверьте данные паспорта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_type(type);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();

            }
        }
        private void changeType_Click(object sender, RoutedEventArgs e)
        {
            string type = textBoxType.Text;
            int id = Convert.ToInt32(textBoxId.Text);
            if (type.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_type(id, type);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void allTypes_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllTypes";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Types.Clear();
                    // Заполняем Dataset
                    command.Fill(Types);
                    // Отображаем данные
                    uGrid.ItemsSource = Types.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }


        private void addProd_Click(object sender, RoutedEventArgs e)
        {
            string type_prod = textBoxType_prod.Text;
            string title_prod = textBoxTitle_prod.Text;
            string author_prod = textBoxAuthor_prod.Text;

            if (type_prod.Length == 0 || title_prod.Length == 0 || author_prod.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_prod(type_prod, title_prod, author_prod);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void dropProd_Click(object sender, RoutedEventArgs e)
        {
            string type_prod = textBoxType_prod.Text;

            if (type_prod.Length == 0)
            {
                MessageBox.Show("Проверьте данные паспорта");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_prod(type_prod);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
                db.closeConnection();
            }
        }
        private void changeProd_Click(object sender, RoutedEventArgs e)
        {
            string type_prod = textBoxType_prod.Text;
            string title_prod = textBoxTitle_prod.Text;
            string author_prod = textBoxAuthor_prod.Text;

            if (type_prod.Length == 0 || title_prod.Length == 0 || author_prod.Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_prod(type_prod, title_prod, author_prod);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void allProd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllProd";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Production.Clear();
                    // Заполняем Dataset
                    command.Fill(Production);
                    // Отображаем данные
                    usGrid.ItemsSource = Production.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }

        private void addOrder_Click(object sender, RoutedEventArgs e)
        {
            DateTime date_start = Order_DateStart.SelectedDate.Value;
            DateTime date_end = Order_DateEnd.SelectedDate.Value;
            int client_order = Convert.ToInt32(textBoxClient_order.Text);
            int production_order = Convert.ToInt32(textBoxProduction_order.Text);
            int cost_order = Convert.ToInt32(textBoxCost_order.Text);

            if (Order_DateStart.SelectedDate.Value == null || Order_DateEnd.SelectedDate.Value == null ||
                    client_order.ToString().Length == 0 || production_order.ToString().Length == 0 || cost_order.ToString().Length == 0 )
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.add_order(date_start, date_end, client_order, production_order, cost_order);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void dropOrder_Click(object sender, RoutedEventArgs e)
        {
            DateTime date_start = Order_DateStart.SelectedDate.Value;
            DateTime date_end = Order_DateEnd.SelectedDate.Value;
           
            if (Order_DateStart.SelectedDate.Value == null || Order_DateEnd.SelectedDate.Value == null)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.drop_order(date_start, date_end);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void changeOrder_Click(object sender, RoutedEventArgs e)
        {
            DateTime date_start = Order_DateStart.SelectedDate.Value;
            DateTime date_end = Order_DateEnd.SelectedDate.Value;
            int client_order = Convert.ToInt32(textBoxClient_order.Text);
            int production_order = Convert.ToInt32(textBoxProduction_order.Text);
            int cost_order = Convert.ToInt32(textBoxCost_order.Text);

            if (Order_DateStart.SelectedDate.Value == null || Order_DateEnd.SelectedDate.Value == null ||
                    client_order.ToString().Length == 0 || production_order.ToString().Length == 0 || cost_order.ToString().Length == 0)
            {
                MessageBox.Show("Проверьте данные");
            }
            else
            {
                DB db = new DB();
                db.openConnection(connStr);
                db.change_order(date_start, date_end, client_order, production_order, cost_order);
                MessageBox.Show("Выполнено !!!");
                db.closeConnection();
            }
        }
        private void allOrder_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string sqlExpression = "getAllOrder";

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(sqlExpression, connection);
                    // указываем, что команда представляет хранимую процедуру
                    Orders.Clear();
                    // Заполняем Dataset
                    command.Fill(Orders);
                    // Отображаем данные
                    userrGrid.ItemsSource = Orders.DefaultView;
                    MessageBox.Show("Выполнено !!!");
                    connection.Close();
                }
            }
            catch
            {
                MessageBox.Show("Ошибка запроса");
            }
        }
        private void specOrder_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("OrdersOfClient", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@datastarta", SqlDbType.Date).Value = Order_DateStart.SelectedDate.Value;
                        cmd.Parameters.AddWithValue("@dataend", SqlDbType.Date).Value = Order_DateEnd.SelectedDate.Value;
                        con.Open();

                        cmd.ExecuteNonQuery();

                        SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        dataAdapter.Fill(dt);
                        userrGrid.ItemsSource = dt.DefaultView;
                        dataAdapter.Update(dt);

                        con.Close();

                        MessageBox.Show("Выполнено !!!");
                        con.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }
    }
}