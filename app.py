from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# Configuración de la base de datos
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Rolonlol135'
app.config['MYSQL_DB'] = 'chacharitaspi'

mysql = MySQL(app)

# Ruta para mostrar todos los clientes
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM clients")
    clients = cur.fetchall()
    cur.close()
    return render_template('index.html', clients=clients)

# Ruta para agregar un nuevo cliente
@app.route('/clients/add', methods=['POST'])
def add_client():
    if request.method == 'POST':
        name = request.form['name']
        last_name = request.form['last_name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        password = request.form['password']
        id_gender = request.form['id_gender']
        id_address = request.form['id_address']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO clients (name, last_name, email, phone_number, password, id_gender, id_address) VALUES (%s, %s, %s, %s, %s, %s, %s)", (name, last_name, email, phone_number, password, id_gender, id_address))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))

# Ruta para eliminar un cliente
@app.route('/clients/delete/<int:id>')
def delete_client(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM clients WHERE id = %s", (id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
